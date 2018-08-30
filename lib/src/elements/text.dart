import 'package:html_builder/src/node.dart';
import 'package:meta/meta.dart';

import 'html_element.dart';

class Text extends HtmlWidget {
  Text._(String tagName, String text,
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners})
      : super(tagName, id, className, style, props, eventListeners,
            [new TextNode(text)]);

  factory Text(String text,
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners}) {
    return new Text._('span', text,
        id: id,
        className: className,
        style: style,
        props: props,
        eventListeners: eventListeners);
  }

  factory Text.b(String text,
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners}) {
    return new Text._('b', text,
        id: id,
        className: className,
        style: style,
        props: props,
        eventListeners: eventListeners);
  }

  factory Text.em(String text,
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners}) {
    return new Text._('i', text,
        id: id,
        className: className,
        style: style,
        props: props,
        eventListeners: eventListeners);
  }

  factory Text.i(String text,
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners}) {
    return new Text._('i', text,
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
      Map<String, void Function(Object)> eventListeners}) {
    return new Text._('strong', text,
        id: id,
        className: className,
        style: style,
        props: props,
        eventListeners: eventListeners);
  }
  factory Text.u(String text,
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners}) {
    return new Text._('u', text,
        id: id,
        className: className,
        style: style,
        props: props,
        eventListeners: eventListeners);
  }
}

class Heading extends HtmlWidget {
  Heading._(
      String tagName,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
      Node child)
      : super(tagName, id, className, style, props, eventListeners, [child]);

  factory Heading.h1(
      {@required Node child,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners}) {
    return new Heading._(
        'h1', id, className, style, props, eventListeners, child);
  }

  factory Heading.h2(
      {@required Node child,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners}) {
    return new Heading._(
        'h2', id, className, style, props, eventListeners, child);
  }

  factory Heading.h3(
      {@required Node child,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners}) {
    return new Heading._(
        'h3', id, className, style, props, eventListeners, child);
  }

  factory Heading.h4(
      {@required Node child,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners}) {
    return new Heading._(
        'h4', id, className, style, props, eventListeners, child);
  }

  factory Heading.h5(
      {@required Node child,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners}) {
    return new Heading._(
        'h5', id, className, style, props, eventListeners, child);
  }

  factory Heading.h6(
      {@required Node child,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners}) {
    return new Heading._(
        'h6', id, className, style, props, eventListeners, child);
  }
}

class Title extends HtmlWidget {
  Title(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
      @required Node child})
      : super('title', id, className, style, props, eventListeners, [child]);
}
