import 'dart:async';
import 'package:html_builder/html_builder.dart';
import 'package:mariposa/mariposa.dart';
import 'package:meta/meta.dart';
import 'package:universal_html/html.dart' show Element, Event;
import 'style.dart';
export '../component.dart';
export 'style.dart';

void Function(Event) castEventHandler<T extends Event>(void Function(T) f) {
  return f == null ? null : (e) => f(e as T);
}

/// Base class for a [Component] that binds to a specific kind of [Element].
///
/// Provides infrastructure for easy event bindings.
class Html5Component<T extends Element> extends ComponentClass<T> {
  final Map<String, void Function(Event)> eventListeners = {};
  final Map<String, dynamic> props = {};
  final String id;
  final dynamic className;
  final Style style;
  final bool selfClosing;
  final List<StreamSubscription> _subscriptions = [];

  Html5Component.bare(
      String key,
      String tagName,
      this.id,
      this.className,
      this.style,
      void Function(T) onMount,
      Ref<T> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children,
      [this.selfClosing = false])
      : super(tagName: tagName, key: key, onMount: onMount, ref: ref) {
    _initialize(children, className, style, props, eventListeners);
  }

  Html5Component.tag(String key, String tagName,
      {this.id,
      this.className,
      this.style,
      void Function(T) onMount,
      Ref<T> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children,
      this.selfClosing = false})
      : super(tagName: tagName, key: key, onMount: onMount, ref: ref) {
    _initialize(children, className, style, props, eventListeners);
  }

  void _initialize(
      Iterable<Node> children,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners) {
    this.children.addAll(children ?? []);
    if (className != null) this.props['class'] = className;
    if (style != null) {
      var buf = style.compile().entries.fold<StringBuffer>(StringBuffer(),
          (b, entry) {
        if (entry.value == null) return b;
        return b..write('${entry.key}: ${entry.value};');
      });
      if (buf.isNotEmpty) this.props['style'] = buf.toString();
    }
    this.props.addAll(props ?? {});
    // if (this.props.isNotEmpty) print('$this => ${this.props}');

    var ev = Map<String, void Function(Event)>.from(eventListeners ?? {});
    ev.removeWhere((_, h) => h == null);
    this.eventListeners.addAll(ev);
  }

  @override
  @mustCallSuper
  void afterMount() {
    eventListeners.forEach((name, callback) {
      _subscriptions.add(nativeElement.on[name].listen(callback));
    });
  }

  @override
  @mustCallSuper
  void afterUnmount() {
    for (var sub in _subscriptions) {
      sub.cancel();
    }
  }

  @override
  Node render() {
    return selfClosing
        ? SelfClosingNode(tagName, props)
        : Node(tagName, props, children);
  }
}
