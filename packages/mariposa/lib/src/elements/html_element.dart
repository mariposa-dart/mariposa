import 'dart:async';
import 'package:html_builder/html_builder.dart';
import 'package:mariposa/mariposa.dart';
import 'package:universal_html/html.dart' show Event;
import 'style.dart';
export 'style.dart';

class BaseHtmlComponent extends ComponentClass {
  final Map<String, void Function(Event)> eventListeners = {};
  final Map<String, dynamic> props = {};
  final String id;
  final dynamic className;
  final Style style;
  final bool selfClosing;
  final List<StreamSubscription> _subscriptions = [];

  BaseHtmlComponent(
      String tagName,
      this.id,
      this.className,
      this.style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children,
      [this.selfClosing = false])
      : super(tagName: tagName) {
    this.children.addAll(children ?? []);
    this.eventListeners.addAll(eventListeners ?? {});
    this.props['class'] = className;
    this.props['style'] = style?.compile();
    this.props.addAll(props ?? {});
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
