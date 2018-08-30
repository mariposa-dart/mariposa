import 'package:html_builder/html_builder.dart';
import 'package:meta/meta.dart';
import 'html_element.dart';

class Button extends HtmlWidget {
  Button._(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
      Iterable<Node> children,
      void Function(Object) onClick,
      void Function(Object) onDoubleClick})
      : super('button', id, className, style, props, eventListeners, children) {
    this.eventListeners['click'] ??= onClick;
    this.eventListeners['dblclick'] ??= onDoubleClick;
  }

  factory Button(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
      @required Node child,
      void Function(Object) onClick,
      void Function(Object) onDoubleClick}) {
    return new Button._(
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
      Map<String, void Function(Object)> eventListeners,
      @required Node icon,
      @required Node child,
      void Function(Object) onClick,
      void Function(Object) onDoubleClick}) {
    return new Button._(
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
