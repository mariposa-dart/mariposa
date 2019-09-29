import 'dart:async';
import 'package:html_builder/html_builder.dart';
import 'package:mariposa/mariposa.dart';
import 'package:universal_html/html.dart' show Event;
import 'style.dart';
export 'style.dart';

void Function(Event) castEventHandler<T extends Event>(void Function(T) f) {
  return f == null ? null : (e) => f(e as T);
}

class BaseHtmlComponent extends ComponentClass {
  final Map<String, void Function(Event)> eventListeners = {};
  final Map<String, dynamic> props = {};
  final String id;
  final dynamic className;
  final Style style;
  final bool selfClosing;
  final List<StreamSubscription> _subscriptions = [];

  BaseHtmlComponent(
      String key,
      String tagName,
      this.id,
      this.className,
      this.style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children,
      [this.selfClosing = false])
      : super(tagName: tagName, key: key) {
    this.children.addAll(children ?? []);
    this.props['class'] = className;
    this.props['style'] = style?.compile();
    this.props.addAll(props ?? {});

    var ev = Map<String, void Function(Event)>.from(eventListeners ?? {});
    ev.removeWhere((_, h) => h == null);
    this.eventListeners.addAll(ev);
  }

  @override
  void afterMount() {
    eventListeners.forEach((name, callback) {
      _subscriptions.add(nativeElement.on[name].listen(callback));
    });
  }

  @override
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
