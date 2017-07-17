import 'dart:async';
import 'dart:html' as html;
import 'package:html_builder/html_builder.dart';
import 'package:html_builder_vdom/html_builder_vdom.dart';
import 'package:meta/meta.dart';
import 'src/state_impl.dart';
import 'mariposa.dart';

void runApp<T>(html.HtmlElement container, MariposaApplication<T> app,
    {DefaultStateProvider<T> defaultState,
    bool bubbleStateEvents,
    StateChangeListener<T> onStateChange}) {
  new _Mariposa<T>(
      container, app, bubbleStateEvents != false, defaultState, onStateChange);
}

class _Mariposa<T> {
  DomRenderer _renderer;
  StateImpl<T> _state;
  final html.HtmlElement container;
  final MariposaApplication<T> entryPoint;
  final bool bubble;
  final DefaultStateProvider<T> defaultState;
  final StateChangeListener<T> onStateChange;

  _Mariposa(this.container, this.entryPoint, this.bubble, this.defaultState,
      this.onStateChange) {
    _state = new StateImpl<T>(null, bubble);

    if (defaultState != null) {
      _state.data.addAll(defaultState());
    }

    _state.lock();
    _renderer = new DomRenderer(container);
    var app = entryPoint();
    var node = app.render(_state);
    var appId = node.hashCode;
    var renderState = _renderer.resolveNodeToState(0, node, container);
    var target =
        _renderer.renderFresh(renderState).target; //_renderer.render(node);
    _DomElementImpl dom = new _DomElementImpl(target);
    app.afterRender(dom, _state);

    void handleState(StateChangeInfo<T> info) {
      // Trigger any state change listeners
      if (onStateChange != null) onStateChange(info);

      var keys = info.key.split('.');
      StateImpl targetState = new StateImpl(null, bubble);
      targetState.data.addAll(_state.data);
      _state.close();
      _state = targetState;

      for (int i = 0; i < keys.length - 1; i++) {
        targetState = targetState.scoped[keys[i]];
      }

      var lastKey = keys.last;
      targetState.data[lastKey] = info.value;

      // Now, re-render the app.
      dom.close();

      var app = entryPoint();
      var node = app.render(_state);
      node = new _SneakyNode(node, appId);
      _renderer.renderDiffed(renderState, node);
      dom = new _DomElementImpl(target);
      app.afterRender(dom, _state);
      //_renderer.renderNode(container, entryPoint().render(_state));
      // TODO: After render for nested widgets...

      _state.onChange.listen(handleState);
    }

    _state.onChange.listen(handleState);
  }

  Node renderWidgets(Node inputNode) {
    // TODO: Replace children...
    // Maybe have to have a custom override element that implements the same hashCode?
    return inputNode;
  }
}

class _SneakyNode<T> implements Node {
  final Node inner;
  final int code;

  _SneakyNode(this.inner, this.code);

  @override
  int get hashCode {
    return code;
  }

  @override
  Map<String, dynamic> get attributes => inner.attributes;

  @override
  List<Node> get children => inner.children;

  @override
  String get tagName => inner.tagName;
}

class _DomElementImpl implements AbstractElement {
  final Map<String, List<StreamSubscription>> _listeners = {};
  final html.Element $el;
  List<AbstractElement> _children, _queries = [];
  AbstractElement _parent;

  _DomElementImpl(this.$el);

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
  void listen<T extends html.Event>(
      String eventName, @checked void callback(T event)) {
    var list = _listeners.putIfAbsent(eventName, () => []);
    var sub = $el.on[eventName].listen(callback);
    list.add(sub);
  }

  @override
  Iterable<AbstractElement> querySelectorAll(String selectors) {
    var results =
        $el.querySelectorAll(selectors).map((c) => new _DomElementImpl(c));
    _queries.addAll(results);
    return results;
  }

  @override
  AbstractElement querySelector(String selectors) {
    var node = $el.querySelector(selectors);
    if (node == null)
      return null;
    else {
      var result = new _DomElementImpl(node);
      _queries.add(result);
      return result;
    }
  }

  @override
  AbstractElement get parent => _parent ??= new _DomElementImpl($el.parent);

  @override
  Iterable<AbstractElement> get children {
    return _children ??= new List<AbstractElement>.unmodifiable(
        $el.children.map((c) => new _DomElementImpl(c)));
  }

  @override
  Map<String, String> get attributes {
    return $el.attributes;
  }

  @override
  String get value {
    if ($el is html.InputElement)
      return ($el as html.InputElement).value;
    else
      return attributes['value'];
  }

  @override
  void set value(String value) {
    if ($el is html.InputElement)
      ($el as html.InputElement).value = value;
    else
      attributes['value'] = value;
  }
}
