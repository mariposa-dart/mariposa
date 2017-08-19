import 'dart:async';
import 'dart:html' as html;
import 'dart:js';
import 'package:html_builder/html_builder.dart';
import 'package:js/js.dart';
import 'package:meta/meta.dart';
import 'src/state_impl.dart';
import 'incremental_dom.dart' as idom;
import 'mariposa.dart';

void runApp<T>(html.HtmlElement container, MariposaApplication<T> app,
    {DefaultStateProvider<T> defaultState,
    bool bubbleStateEvents,
    StateChangeListener<T> onStateChange}) {
  new _Mariposa<T>(
      container, app, bubbleStateEvents != false, defaultState, onStateChange);
}

class _Mariposa<T> {
  StateImpl<T> _state;
  final html.HtmlElement container;
  final MariposaApplication<T> entryPoint;
  final bool bubble;
  final DefaultStateProvider<T> defaultState;
  final StateChangeListener<T> onStateChange;
  final List<_DomElementImpl> _refs = [];

  _Mariposa(this.container, this.entryPoint, this.bubble, this.defaultState,
      this.onStateChange) {
    _state = new StateImpl<T>(null, bubble);

    if (defaultState != null) {
      _state.data.addAll(defaultState());
    }

    _state.lock();
    idom.patch(container, allowInterop(_patchCallback));

    void handleState(StateChangeInfo<T> info) {
      if (info.key != null) {
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
      }

      while (_refs.isNotEmpty) _refs.removeAt(0).close();

      // Now, re-render the app.
      idom.patch(container, allowInterop(_patchCallback));
      if (info.key != null) _state.onChange.listen(handleState);
    }

    _state.onChange.listen(handleState);

    idom.notifications.nodesRemoved = (nodes) {
      nodes.forEach((node) {
        var refs = _refs.where((d) => d.$el == node);

        for (var ref in refs)
          _refs.remove(ref..close());
      });
    };
  }

  static List compileAttributes(Map<String, dynamic> props) {
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

  void _patchCallback([_]) {
    _renderInner(entryPoint(), _state);
  }

  void _renderInner(Node node, State state) {
    if (node is Widget) {
      _renderWidget(node, state);
    } else {
      _renderNode(node, state);
    }
  }

  html.Element _renderNode(Node node, State state) {
    if (node is TextNode) {
      idom.text(node.text);
      return null;
    } else {
      // TODO: Assign ID's?
      var attrs = compileAttributes(node.attributes);
      idom.elementOpen(node.tagName, node.attributes['key']?.toString() ?? '', attrs);

      for (var c in node.children) _renderInner(c, state);

      return idom.elementClose(node.tagName);
    }
  }

  void _renderWidget(Widget widget, State state) {
    var node = widget.render(state);
    var target = _renderNode(node, state);

    if (!_refs.any((d) => d.$el == target)) {
      var ref = new _DomElementImpl(target);
      _refs.add(ref);
      widget.afterRender(ref, state);
    }
  }
}

/// Unwraps an [AbstractElement] into its native element.
html.Element unwrap(AbstractElement elementRef) {
  if (elementRef is! _DomElementImpl)
    throw new UnsupportedError('Cannot unwrap ${elementRef.runtimeType} in the browser.');
  return (elementRef as _DomElementImpl).$el;
}

class _DomElementImpl implements AbstractElement<html.Event> {
  final Map<String, List<StreamSubscription>> _listeners = {};
  final html.Element $el;
  List<AbstractElement<html.Event>> _children, _queries = [];
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
  Iterable<AbstractElement<html.Event>> querySelectorAll(String selectors) {
    var results =
        $el.querySelectorAll(selectors).map((c) => new _DomElementImpl(c));
    _queries.addAll(results);
    return results;
  }

  @override
  AbstractElement<html.Event> querySelector(String selectors) {
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
  AbstractElement<html.Event> get parent =>
      _parent ??= new _DomElementImpl($el.parent);

  @override
  Iterable<AbstractElement<html.Event>> get children {
    return _children ??= new List<AbstractElement<html.Event>>.unmodifiable(
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
