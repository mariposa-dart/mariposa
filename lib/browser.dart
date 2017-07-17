import 'dart:html' as html;
import 'package:html_builder/html_builder.dart';
import 'package:html_builder_vdom/html_builder_vdom.dart';
import 'src/default_state.dart';
import 'mariposa.dart';

typedef Widget<T> MariposaApplication<T>();
typedef Map<String, T> DefaultStateProvider<T>();
typedef void StateChangeListener<T>(StateChangeInfo<T> changeInfo);

void runApp<T>(html.HtmlElement container, MariposaApplication<T> app,
    {DefaultStateProvider<T> defaultState,
    bool bubbleStateEvents,
    StateChangeListener<T> onStateChange}) {
  new _Mariposa(
      container, app, bubbleStateEvents != false, defaultState, onStateChange);
}

class _Mariposa<T> {
  DomRenderer _renderer;
  DefaultState<T> _state;
  final html.HtmlElement container;
  final MariposaApplication<T> entryPoint;
  final bool bubble;
  final DefaultStateProvider<T> defaultState;
  final StateChangeListener<T> onStateChange;

  _Mariposa(this.container, this.entryPoint, this.bubble, this.defaultState,
      this.onStateChange) {
    _state = new DefaultState<T>();

    if (defaultState != null) {
      _state.data.addAll(defaultState());
    }

    _state.lock();
    _renderer = new DomRenderer(container);
    Node currentApp;
    var a = entryPoint();
    var r = _renderer.render(currentApp = renderWidgets(a.render(_state)));
    a.afterRender(r, _state);

    var rState = _renderer.resolveNodeToState(-1, currentApp);

    _state.onChange.listen((info) {
      if (onStateChange != null) onStateChange(info);

      var keys = info.key.split('.');
      DefaultState targetState = _state;

      for (int i = 0; i < keys.length - 1; i++) {
        targetState = targetState.scoped[keys[i]];
      }

      var lastKey = keys.last;
      targetState.data[lastKey] = info.value;
      print(_state.data);

      var id = currentApp.hashCode;
      var a = entryPoint();

      var r = _renderer.renderDiffed(
          rState, currentApp = new _SneakyNode(renderWidgets(a.render(_state)), id));
      a.afterRender(r.target, _state);
      // TODO: After render...
    });
  }

  Node renderWidgets(Node inputNode) {
    // TODO: Replace children...
    // Maybe have to have a custom override element that implements the same hashCode?
    return inputNode;
  }
}

class _SneakyNode<T> implements Node {
  final Widget<T> inner;
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
