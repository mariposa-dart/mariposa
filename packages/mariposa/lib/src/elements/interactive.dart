import 'package:html_builder/html_builder.dart';
import 'package:meta/meta.dart';
import 'package:universal_html/html.dart' show Event;
import 'html_element.dart';

class Button extends BaseHtmlComponent {
  Button._(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children,
      void Function(Event) onClick,
      void Function(Event) onDoubleClick})
      : super('button', id, className, style, props, eventListeners, children) {
    this.eventListeners['click'] ??= onClick;
    this.eventListeners['dblclick'] ??= onDoubleClick;
  }

  factory Button(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      @required Node child,
      void Function(Event) onClick,
      void Function(Event) onDoubleClick}) {
    return Button._(
        id: id,
        className: className,
        style: style,
        props: props,
        eventListeners: eventListeners,
        children: [child],
        onClick: onClick,
        onDoubleClick: onDoubleClick);
  }

  factory Button.icon(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      @required Node icon,
      @required Node child,
      void Function(Event) onClick,
      void Function(Event) onDoubleClick}) {
    return Button._(
        id: id,
        className: className,
        style: style,
        props: props,
        eventListeners: eventListeners,
        children: [icon, child],
        onClick: onClick,
        onDoubleClick: onDoubleClick);
  }
}
