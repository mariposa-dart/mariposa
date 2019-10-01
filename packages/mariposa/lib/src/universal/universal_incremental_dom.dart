import 'dart:async';
import 'dart:collection';
import 'package:mariposa/mariposa.dart' show IncrementalDom, mariposaKey;
import 'package:universal_html/html.dart';

class UniversalIncrementalDom extends IncrementalDom<Node, Element> {
  final StreamController<Node> _onNodeCreated = StreamController(),
      _onNodeDeleted = StreamController();
  final Queue<Element> _elementStack = Queue();
  final Queue<int> _childIndexStack = Queue();
  final Set<int> _created = Set();
  bool _isPatching = false;

  @override
  Stream<Node> get onNodeCreated => _onNodeCreated.stream;

  @override
  Stream<Node> get onNodeDeleted => _onNodeDeleted.stream;

  @override
  Future<void> close() {
    _onNodeCreated.close();
    _onNodeDeleted.close();
    return Future.value();
  }

  StateError _emptyStack() =>
      StateError('The InMemoryIncrementalDom element stack is empty.');

  void createNode(Element node) {
    if (_created.add(node.hashCode)) {
      _onNodeCreated.add(node);
    }
    node.children.forEach(createNode);
  }

  void destroyNode(Element node) {
    _onNodeDeleted.add(node);
    node.children.forEach(destroyNode);
  }

  @override
  Element elementClose(String tagName) {
    tagName = tagName.toLowerCase();
    if (_elementStack.isEmpty) {
      throw _emptyStack();
    } else if (_elementStack.first.localName.toLowerCase() != tagName) {
      throw StateError('elementClose() was called with "$tagName", '
          'but the current element has tag name '
          '"${_elementStack.first.localName.toLowerCase()}".');
    }
    var node = _elementStack.removeFirst();
    if (_elementStack.isNotEmpty) {
      // If we are patching, modify the children in-place.
      // Otherwise, add the element to the parent.
      if (_isPatching) {
        if (_childIndexStack.length < 2 ||
            (_elementStack.length >= 2 &&
                _childIndexStack.first >=
                    _elementStack.elementAt(1).childNodes.length)) {
          _elementStack.first.append(node);
          createNode(node);
        } else {
          // In elementOpen(), we pushed a childIndex. Pop it.
          var lastIndex = _childIndexStack.removeFirst();

          // However, the parent may be an element with multiple children, so
          // we should increment the child index if so.
          if (_childIndexStack.isNotEmpty && _childIndexStack.first != -1) {
            // Because this is an in-place modification, actually do nothing here.
            // Just increment the child index.
            _childIndexStack.addFirst(_childIndexStack.removeFirst() + 1);
          } else {
            // If this is the root of the tree we are patching, remove any
            // leftover children.
            if (lastIndex >= 0 && lastIndex < node.childNodes.length) {
              node.childNodes
                  .skip(lastIndex)
                  .take(node.childNodes.length - lastIndex)
                  .whereType<Element>()
                  .forEach(destroyNode);
              node.childNodes.removeRange(lastIndex, node.children.length);
            }
          }
        }
      } else {
        _elementStack.first.append(node);
      }
    }
    if (!_isPatching) {
      createNode(node);
    }
    return node;
  }

  @override
  void elementOpen(String tagName, String id, Map<String, dynamic> attributes) {
    var replaceIndex = _childIndexStack.isEmpty ? -1 : _childIndexStack.first;
    Node replace;

    // If we're patching, _childIndex will be -1 at the root.
    if (_isPatching &&
        replaceIndex != -1 &&
        replaceIndex < _elementStack.first.childNodes.length) {
      // If we're patching, see if we can find an existing element.
      // Loop through the parent's children, searching until we find the `id`.
      // If we find the ID, delete all of the existing children that precede it.
      // Otherwise, use the child at the current index. If the index is greater
      // than the parent's child count, create a node.
      var parent = _elementStack.first;
      if (id != null) {
        var destroy = <Element>[];
        var initReplaceIndex = replaceIndex;
        for (replaceIndex;
            replaceIndex < parent.childNodes.length;
            replaceIndex++) {
          var child = parent.childNodes[replaceIndex];
          if (child is Element && child.attributes[mariposaKey] != id) {
            destroy.add(child);
          } else {
            replace = child;
            break;
          }
        }
        if (replace != null) {
          parent.childNodes.removeRange(initReplaceIndex, replaceIndex);
          destroy.forEach(destroyNode);
        }
      }
      if (replace == null) {
        replace = parent.childNodes[_childIndexStack.first];
      }
    }

    // If the two elements do not share a tag name, delete the old one.
    if (replace is Element && tagName != replace.localName.toLowerCase()) {
      destroyNode(replace as Element);
      // print('Trying to replace $replace with $tagName');
      // _elementStack.first.children[_childIndexStack.first] = null;
      replace = null;
    }

    var attrs = attributes.map((k, v) => MapEntry(k, v.toString()));
    if (id != null) {
      attrs[mariposaKey] = id;
    }
    if (replace == null) {
      var element = Element.tag(tagName)..attributes.addAll(attrs);
      _elementStack.addFirst(element);
    } else if (replace is Element) {
      replace.attributes
        ..clear()
        ..addAll(attrs);
      _elementStack.addFirst(replace);
      _childIndexStack.addFirst(0);
    }
  }

  @override
  Element elementVoid(
      String tagName, String id, Map<String, dynamic> attributes) {
    elementOpen(tagName, id, attributes);
    return elementClose(tagName);
  }

  @override
  void patch(Element element, void Function() callback) {
    var oldP = _isPatching;
    _isPatching = true;
    _elementStack.addFirst(element);
    // _childIndexStack.addFirst(-1);
    _childIndexStack.addFirst(0);
    callback();
    // _childIndexStack.removeFirst();
    _isPatching = oldP;
  }

  @override
  Node text(String text) {
    if (_elementStack.isEmpty) {
      throw _emptyStack();
    }
    var node = Text(text);
    if (!_isPatching) {
      _elementStack.first.append(node);
    } else {
      var childIndex = _childIndexStack.first;
      var parent = _elementStack.first;
      if (childIndex < parent.childNodes.length) {
        var existing = parent.childNodes[childIndex];
        // parent.childNodes[childIndex] = Text(text);
        parent.childNodes[childIndex].replaceWith(Text(text));
        if (existing is Element) destroyNode(existing);
      } else {
        parent.append(node);
      }
      _childIndexStack
        ..removeFirst()
        ..addFirst(childIndex + 1);
    }
    return node;
  }
}
