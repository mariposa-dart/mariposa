import 'dart:async';
import 'package:html_builder/html_builder.dart';
import '../abstract_element.dart';
import '../widgets.dart';
import 'style.dart';
export 'style.dart';

class HtmlWidget extends Widget {
  final Map<String, void Function(Object)> eventListeners = {};
  final Map<String, dynamic> props = {};
  final String id;
  final dynamic className;
  final Style style;
  final bool selfClosing;
  final List<StreamSubscription> _subscriptions = [];

  HtmlWidget(
      String tagName,
      this.id,
      this.className,
      this.style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
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
  void afterRender(AbstractElement element) {
    eventListeners.forEach((name, callback) {
      _subscriptions.add(element.listen(name, callback));
    });
  }

  @override
  void beforeDestroy(AbstractElement element) {
    for (var sub in _subscriptions) {
      sub.cancel();
    }
  }

  @override
  Node render() {
    return selfClosing
        ? new SelfClosingNode(tagName, props)
        : new Node(tagName, props, children);
  }
}
