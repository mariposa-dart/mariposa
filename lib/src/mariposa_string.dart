import 'dart:async';
import 'package:html_builder/html_builder.dart';
import 'package:zen/zen.dart';
import 'abstract_element.dart';
import 'widgets.dart';

/// Renders a tree into a [String].
String render(Node Function() app, {StringRenderer Function() createRenderer}) {
  createRenderer ??= () => new StringRenderer();
  var renderer = createRenderer();
  var noOpStreamCtrl = new StreamController.broadcast();
  var out = _renderInner(app(), renderer, null, noOpStreamCtrl.stream);
  var result = renderer.render(out);
  noOpStreamCtrl.close();
  return result;
}

Node _renderInner(Node node, StringRenderer renderer, _StringElementImpl parent,
    Stream events) {
  if (node is Widget)
    node = _renderWidget(node as Widget, renderer, parent, events);
  return _renderNode(node, renderer, events);
}

Node _renderNode(Node node, StringRenderer renderer, Stream events) => node;

Node _renderWidget(Widget widget, StringRenderer renderer,
    _StringElementImpl parent, Stream events) {
  var children = <Node>[];
  var node = widget.render();
  var ref = new _StringElementImpl(node, parent, events);

  for (var child in node.children) {
    children.add(_renderInner(child, renderer, ref, events));
  }

  widget.afterRender(ref);
  return new Node(node.tagName, node.attributes, children);
}

class _StringElementImpl implements AbstractElement<dynamic, Node> {
  final Stream events;
  final Node nativeElement;
  final AbstractElement<dynamic, Node> _parent;
  List<AbstractElement<dynamic, Node>> _children;

  _StringElementImpl(this.nativeElement, this._parent, this.events);

  @override
  Future close() {
    return new Future.value();
  }

  @override
  StreamSubscription<T> listen<T>(String eventName, void callback(T event)) {
    return events.cast<T>().listen(callback);
  }

  @override
  Iterable<AbstractElement<dynamic, Node>> querySelectorAll(String selectors) {
    return Zen
        .querySelectorAll(nativeElement, selectors)
        .map((n) => new _StringElementImpl(n, this, events));
  }

  @override
  AbstractElement<dynamic, Node> querySelector(String selectors) {
    var el = Zen.querySelector(nativeElement, selectors);
    return el == null ? null : new _StringElementImpl(el, this, events);
  }

  @override
  Map<String, String> get attributes {
    return nativeElement.attributes
        .map((k, v) => new MapEntry(k, v.toString()));
  }

  @override
  void set value(String value) {
    attributes['value'] = value;
  }

  @override
  String get value {
    return attributes['value'];
  }

  @override
  AbstractElement<dynamic, Node> get parent {
    return _parent;
  }

  @override
  Iterable<AbstractElement<dynamic, Node>> get children {
    return _children ??= new List<AbstractElement<dynamic, Node>>.unmodifiable(
        nativeElement.children
            .map((n) => new _StringElementImpl(nativeElement, this, events)));
  }
}
