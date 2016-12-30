import 'dart:async';
import 'dart:html';
import 'mariposa.dart' as m;

final Mariposa MARIPOSA = new Mariposa();
const String MARIPOSA_ID = 'mariposa-id';

void TIME_TRAVEL(m.StateUpdateEvent e) {
  ['STATE UPDATE: ${e.key} = ${e.value}', 'Previous state:', e.oldState]
      .forEach(print);
}

class Mariposa {
  final StreamController<m.StateUpdateEvent> _onUpdate =
      new StreamController<m.StateUpdateEvent>.broadcast();
  m.Node _root;
  Element _rootElement;
  m.State _state;
  Element _target;
  final Map<int, int> _memo = {};

  Stream<m.StateUpdateEvent> get onUpdate => _onUpdate.stream;

  void render(m.Node rootNode, Element target,
      {Map<String, dynamic> initialState}) {
    _state = new m.State.fromMap(initialState ?? {});
    _target = target;

    var converted = _convertToNode(_root = rootNode);
    _renderInto(rootNode is m.Widget ? rootNode : null, converted,
        _rootElement = document.createElement(converted.tagName));
    target.children
      ..clear()
      ..add(_rootElement);

    if (rootNode is m.Widget) {
      _listenToState(rootNode.state);
    }
  }

  void _listenToState(m.State state) {
    state.onUpdate.listen((e) {
      _onUpdate.add(e);
      _listenToState(_state = new m.State.fromMap(e.newState));

      // Todo: Update
      _updateElem(
          _target, _root, _convertToNode(_root), e.oldState, e.newState);

      // render(_root, _target, initialState: e.newState);

      // Todo: Clear memo
      // _memo.clear();
    });
  }

  void _renderInto(m.Widget source, m.Node node, Element target,
      {int existingId}) {
    var converted = _convertToNode(node);

    _copyAttributes(converted, target);

    int id = existingId ?? _memoize(source ?? node, target);

    for (var childNode in converted.children) {
      if (childNode is m.TextNode) {
        target.text = childNode.text;
        _memo[childNode.hashCode] = id;
      }
    }

    for (var childNode in converted.children) {
      if (childNode is m.TextNode) continue;

      var converted = _convertToNode(childNode);
      var childElement = document.createElement(converted.tagName);
      target.children.add(childElement);
      _renderInto(
          childNode is m.Widget ? childNode : null, converted, childElement,
          existingId: _memo[childNode]);
    }

    if (source != null) {
      source.afterRender(target);
    }
  }

  void _copyAttributes(m.Node node, Element target) {
    node.attributes.forEach((k, v) {
      if (k != 'class' && k != 'style') {
        target.attributes[k] = v.toString();
      } else if (k == 'class') {
        if (v is String) {
          target.attributes['class'] = v;
        } else if (v is List) {
          target.classes.addAll(v.map((x) => x.toString()));
        }
      } else {
        if (v is String) {
          target.attributes['style'] = v;
        } else if (v is Map<String, dynamic>) {
          v.forEach(target.style.setProperty);
        }
      }
    });
  }

  m.Node _convertToNode(m.Node node) {
    if (node is m.Widget) {
      node.state = _state;
      return node.render();
    } else
      return node;
  }

  m.Widget _convertToWidget(m.Node node) {
    return node is m.Widget ? node : null;
  }

  int _memoize(m.Node node, Element target) {
    int id = _memo.containsKey(node.hashCode)
        ? _memo[node.hashCode]
        : _memo[node.hashCode] = _memo.length;
    target.dataset[MARIPOSA_ID] = id.toString();
    return id;
  }

  // Todo: Lists...
  // Also, keep track of ID's...
  void _updateElem(Element $parent, m.Node oldNode, m.Node newNode,
      Map<String, dynamic> oldState, Map<String, dynamic> newState,
      [int index = 0]) {
    if (oldNode == null) {
      if (newNode is m.TextNode) {
        $parent?.text = newNode.text;
      } else {
        var converted = _convertToNode(newNode);
        var $el = document.createElement(converted.tagName);
        $parent.children.add($el);
        int id = _memoize(newNode, $el);
        _renderInto(_convertToWidget(newNode), newNode, $el, existingId: id);
      }

      return;
    }

    if (newNode == null) {
      if (oldNode is! m.TextNode) {
        var existingId = _memo[oldNode.hashCode];
        var existing = querySelector('[data-$MARIPOSA_ID="$existingId"]');
        existing?.remove();
      }

      return;
    }

    if (_nodeChanged(oldNode, newNode)) {
      // window.console..log('Changed!')..log($parent)..log(oldNode)..log(newNode);
      var existingId = _memo[oldNode.hashCode] ?? _memo[newNode.hashCode];
      var query = '[data-$MARIPOSA_ID="$existingId"]';
      var existing = querySelector(query);

      if (newNode is m.TextNode) {
        existing?.text = newNode.text;
      } else {
        var converted = _convertToNode(newNode);
        var $el = document.createElement(converted.tagName);
        var widget = _convertToWidget(newNode);
        _renderInto(widget, newNode, $el, existingId: existingId);
        _memo
          //..remove(oldNode.hashCode)
          ..[newNode.hashCode] = existingId;
        _memoize(newNode, $el);
        existing?.replaceWith($el);
        widget?.afterRender($el);
      }
      return;
    }

    var oldChildren = oldNode.children, newChildren = newNode.children;
    var existingId = _memo[oldNode.hashCode];
    var existing = querySelector('[data-$MARIPOSA_ID="$existingId"]');

    for (int i = 0; i < oldChildren.length || i < newChildren.length; i++) {
      _updateElem(
          existing,
          oldChildren.length > i ? oldChildren[i] : null,
          newChildren.length > i ? newChildren[i] : null,
          oldState,
          newState,
          i);
    }
  }

  bool _nodeChanged(m.Node oldNode, m.Node newNode) {
    return (oldNode.runtimeType != newNode.runtimeType) ||
        (oldNode is m.TextNode && oldNode != newNode) ||
        (oldNode.tagName != newNode.tagName);
  }
}
