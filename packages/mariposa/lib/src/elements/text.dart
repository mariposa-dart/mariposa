import 'package:html_builder/src/node.dart';
import 'package:meta/meta.dart';
import 'package:universal_html/html.dart' show Event;
import 'html_element.dart';

class Text extends BaseHtmlComponent {
  Text._(String tagName, String text,
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners})
      : super(key, tagName, id, className, style, props, eventListeners,
            [TextNode(text)]);

  factory Text(String text,
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Text._('span', text,
        key: key,
        id: id,
        className: className,
        style: style,
        props: props,
        eventListeners: eventListeners);
  }

  factory Text.bold(String text,
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Text._('b', text,
        id: id,
        key: key,
        className: className,
        style: style,
        props: props,
        eventListeners: eventListeners);
  }

  factory Text.emphasized(String text,
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Text._('i', text,
        id: id,
        key: key,
        className: className,
        style: style,
        props: props,
        eventListeners: eventListeners);
  }

  factory Text.italicized(String text,
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Text._('i', text,
        id: id,
        key: key,
        className: className,
        style: style,
        props: props,
        eventListeners: eventListeners);
  }

  factory Text.strong(String text,
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Text._('strong', text,
        id: id,
        key: key,
        className: className,
        style: style,
        props: props,
        eventListeners: eventListeners);
  }
  factory Text.underlined(String text,
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Text._('u', text,
        id: id,
        key: key,
        className: className,
        style: style,
        props: props,
        eventListeners: eventListeners);
  }
}

class Heading extends BaseHtmlComponent {
  Heading._(
      String key,
      String tagName,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Node child)
      : super(
            key, tagName, id, className, style, props, eventListeners, [child]);

  factory Heading.h1(
      {@required Node child,
      String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Heading._(
        key, 'h1', id, className, style, props, eventListeners, child);
  }

  factory Heading.h2(
      {@required Node child,
      String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Heading._(
        key, 'h2', id, className, style, props, eventListeners, child);
  }

  factory Heading.h3(
      {@required Node child,
      String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Heading._(
        key, 'h3', id, className, style, props, eventListeners, child);
  }

  factory Heading.h4(
      {@required Node child,
      String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Heading._(
        key, 'h4', id, className, style, props, eventListeners, child);
  }

  factory Heading.h5(
      {@required Node child,
      String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Heading._(
        key, 'h5', id, className, style, props, eventListeners, child);
  }

  factory Heading.h6(
      {@required Node child,
      String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners}) {
    return Heading._(
        key, 'h6', id, className, style, props, eventListeners, child);
  }
}

class Title extends BaseHtmlComponent {
  Title(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      @required Node child})
      : super(
            key, 'title', id, className, style, props, eventListeners, [child]);
}
