import 'dart:async';
import 'package:html_builder/html_builder.dart';
import 'src/state_impl.dart';
import 'mariposa.dart';

Node runApp<T>(MariposaApplication<T> app,
    {DefaultStateProvider<T> defaultState}) {
  var m = new _Mariposa<T>(app, defaultState);
  return m.render();
}

// TODO: Run afterRender hooks
class _Mariposa<T> {
  final MariposaApplication<T> app;
  final DefaultStateProvider<T> defaultState;

  _Mariposa(this.app, this.defaultState);

  Node render() {
    var state = new StateImpl();

    if (defaultState != null) state.data.addAll(defaultState());

    var root = app();
    var node = build(root, null, state);
    state.close();
    return node;
  }

  Node build(Node node, Node parent, State state) {
    var a = app().render(state);

    while (a is Widget) {
      a = (a as Widget).render(state);
    }

    if (a.children.any((n) => n is Widget)) {
      a = new Node(
        a.tagName,
        a.attributes,
        a.children.map((n) => build(n, node, state)).toList(),
      );
    }

    if (parent == null) {
      var attrs = new Map<String, dynamic>.from(a.attributes)
        ..['data-mariposa'] = 'true';
      a = new Node(
        a.tagName,
        attrs,
        a.children,
      );
    }

    return a;
  }
}

class _StringElementImpl implements AbstractElement {
  final Node node;
  final AbstractElement _parent;
  List<AbstractElement> _children;

  _StringElementImpl(this.node, this._parent);

  @override
  Future close() {
    return new Future.value();
  }

  @override
  void listen<T>(String eventName, void callback(T event)) {
    // Do nothing.
  }

  @override
  Iterable<AbstractElement> querySelectorAll(String selectors) {
    // TODO: Query selectors
    throw new UnsupportedError(
        'Query selectors are not yet available for server-side rendering.');
  }

  @override
  AbstractElement querySelector(String selectors) {
    throw new UnsupportedError(
        'Query selectors are not yet available for server-side rendering.');
  }

  @override
  Map<String, String> get attributes {
    return node.attributes;
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
  AbstractElement get parent {
    return _parent;
  }

  @override
  Iterable<AbstractElement> get children {
    return _children ??= new List<AbstractElement>.unmodifiable(
        node.children.map((n) => new _StringElementImpl(node, this)));
  }
}
