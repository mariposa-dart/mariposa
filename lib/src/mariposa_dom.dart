import 'dart:async';
import 'dart:html' hide Node;
import 'dart:html' as html show Node;
import 'dart:js';
import 'package:html_builder/html_builder.dart';
import 'package:js/js.dart';
import 'abstract_element.dart';
import 'incremental_dom.dart' as idom;
import 'widgets.dart';

final Map<html.Node, List<_DomElementImpl>> _elements = {};
void Function(NodeList) _nodesRemoved;

/// Returns a one-off function that can be called to check for updates and render the tree.
void Function() render(Node Function() app, Element container) {
  if (_nodesRemoved == null) {
    _nodesRemoved =
        idom.notifications.nodesDeleted = allowInterop((NodeList list) {
      for (var domNode in list) {
        if (_elements.containsKey(domNode)) {
          var elements = _elements[domNode];

          while (elements.isNotEmpty) {
            var el = elements.removeLast();
            if (el._onDestroy != null) el._onDestroy();
          }
        }
      }
    });
  }

  var fn = allowInterop(([n]) => _renderInner(app()));
  var rerender = () => idom.patch(container, fn);
  rerender();
  return rerender;
}

void _renderInner(Node node) {
  if (node is Widget) {
    _renderWidget(node);
  } else {
    _renderNode(node);
  }
}

Element _renderNode(Node node) {
  if (node is TextNode) {
    idom.text(node.text);
    return null;
  } else {
    // TODO: Assign ID's?
    var attrs = _compileAttributes(node.attributes.cast());

    if (node is SelfClosingNode) {
      return idom.elementVoid(
          node.tagName,
          node.attributes['id']?.toString() ??
              node.attributes['key']?.toString() ??
              '',
          attrs);
    } else {
      idom.elementOpen(
          node.tagName,
          node.attributes['id']?.toString() ??
              node.attributes['key']?.toString() ??
              '',
          attrs);
      for (var c in node.children) _renderInner(c);

      return idom.elementClose(node.tagName);
    }
  }
}

void _renderWidget(Widget widget) {
  var node = widget.render(); //state);
  var target = _renderNode(node); //, state);

  if (!_elements.containsKey(target)) {
    //if (!_refs.any((d) => d.$el == target)) {
    var ref = new _DomElementImpl(target);
    ref._onDestroy = () => widget.beforeDestroy(ref);
    //_refs.add(ref);
    widget.afterRender(ref); //, state);
  }
  //}
}

List _compileAttributes(Map props) {
  var out = [];

  props.forEach((k, v) {
    if (v == null || v == false) return;

    out.add(k);

    if (v is JsFunction)
      out.add(v);
    else if (v is JsObject)
      out.add(v);
    else if (v == true)
      out.add(k);
    else if (v is List)
      out.add(v.join(', '));
    else if (v is Map) {
      int i = 0;
      var b = v.keys.fold<StringBuffer>(new StringBuffer(), (out, k) {
        if (i++ > 0) out.write('; ');
        return out..write('$k: ${v[k]}');
      });
      out.add(b.toString());
    } else
      out.add(v.toString());
  });

  return out;
}

class _DomElementImpl implements AbstractElement<Event, Element> {
  final Map<String, List<StreamSubscription>> _listeners = {};
  final Element nativeElement;
  List<AbstractElement<Event, Element>> _children, _queries = [];
  AbstractElement<Event, Element> _parent;
  void Function() _onDestroy;

  _DomElementImpl(this.nativeElement) {
    _elements.putIfAbsent(nativeElement, () => []).add(this);
  }

  @override
  Future close() {
    _children?.forEach((el) => el.close());
    _queries?.forEach((el) => el.close());
    _parent?.close();

    _listeners.values.forEach((listeners) {
      listeners.forEach((s) => s.cancel());
    });

    return new Future.value();
  }

  @override
  StreamSubscription<T> listen<T>(
      String eventName, void callback(T event)) {
    var list = _listeners.putIfAbsent(eventName, () => []);
    var sub = nativeElement.on[eventName].cast<T>().listen(callback);
    list.add(sub);
    return sub;
  }

  @override
  Iterable<AbstractElement<Event, Element>> querySelectorAll(String selectors) {
    var results = nativeElement
        .querySelectorAll(selectors)
        .map((c) => new _DomElementImpl(c));
    _queries.addAll(results);
    return results;
  }

  @override
  AbstractElement<Event, Element> querySelector(String selectors) {
    var node = nativeElement.querySelector(selectors);
    if (node == null)
      return null;
    else {
      var result = new _DomElementImpl(node);
      _queries.add(result);
      return result;
    }
  }

  @override
  AbstractElement<Event, Element> get parent =>
      _parent ??= new _DomElementImpl(nativeElement.parent);

  @override
  Iterable<AbstractElement<Event, Element>> get children {
    return _children ??= new List<AbstractElement<Event, Element>>.unmodifiable(
        nativeElement.children.map((c) => new _DomElementImpl(c)));
  }

  @override
  Map<String, String> get attributes {
    return nativeElement.attributes;
  }

  @override
  String get value {
    if (nativeElement is InputElement)
      return (nativeElement as InputElement).value;
    else
      return attributes['value'];
  }

  @override
  void set value(String value) {
    if (nativeElement is InputElement)
      (nativeElement as InputElement).value = value;
    else
      attributes['value'] = value;
  }
}
