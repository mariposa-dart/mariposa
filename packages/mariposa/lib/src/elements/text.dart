import 'package:html_builder/src/node.dart';
import 'package:meta/meta.dart';
import 'package:universal_html/html.dart' show Event;
import 'html_element.dart';

class Text extends BaseHtmlComponent {
  Text._(String tagName, String text,
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners})
      : super(tagName, id, className, style, props, eventListeners,
            [TextNode(text)]);

  factory Text(String text,
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Text._('span', text,
        id: id,
        className: className,
        style: style,
        props: props,
        eventListeners: eventListeners);
  }

  factory Text.bold(String text,
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Text._('b', text,
        id: id,
        className: className,
        style: style,
        props: props,
        eventListeners: eventListeners);
  }

  factory Text.emphasized(String text,
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Text._('i', text,
        id: id,
        className: className,
        style: style,
        props: props,
        eventListeners: eventListeners);
  }

  factory Text.italicized(String text,
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Text._('i', text,
        id: id,
        className: className,
        style: style,
        props: props,
        eventListeners: eventListeners);
  }

  factory Text.strong(String text,
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Text._('strong', text,
        id: id,
        className: className,
        style: style,
        props: props,
        eventListeners: eventListeners);
  }
  factory Text.underlined(String text,
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Text._('u', text,
        id: id,
        className: className,
        style: style,
        props: props,
        eventListeners: eventListeners);
  }
}

class Heading extends BaseHtmlComponent {
  Heading._(
      String tagName,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Node child)
      : super(tagName, id, className, style, props, eventListeners, [child]);

  factory Heading.h1(
      {@required Node child,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Heading._('h1', id, className, style, props, eventListeners, child);
  }

  factory Heading.h2(
      {@required Node child,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Heading._('h2', id, className, style, props, eventListeners, child);
  }

  factory Heading.h3(
      {@required Node child,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Heading._('h3', id, className, style, props, eventListeners, child);
  }

  factory Heading.h4(
      {@required Node child,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Heading._('h4', id, className, style, props, eventListeners, child);
  }

  factory Heading.h5(
      {@required Node child,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Heading._('h5', id, className, style, props, eventListeners, child);
  }

  factory Heading.h6(
      {@required Node child,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Heading._('h6', id, className, style, props, eventListeners, child);
  }
}

class Title extends BaseHtmlComponent {
  Title(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      @required Node child})
      : super('title', id, className, style, props, eventListeners, [child]);
}
