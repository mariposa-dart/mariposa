import 'package:html_builder/html_builder.dart';
import 'package:universal_html/html.dart' show Event;
import 'html_element.dart';

class Article extends BaseHtmlComponent {
  Article(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super(key, 'article', id, className, style, props, eventListeners,
            children);
}

class Aside extends BaseHtmlComponent {
  Aside(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super(key, 'aside', id, className, style, props, eventListeners,
            children);
}

class Body extends BaseHtmlComponent {
  Body(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super(
            key, 'body', id, className, style, props, eventListeners, children);
}

class BR extends BaseHtmlComponent {
  BR(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners})
      : super(key, 'br', id, className, style, props, eventListeners, [], true);
}

class Div extends BaseHtmlComponent {
  Div(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super(
            key, 'div', id, className, style, props, eventListeners, children);
}

class Head extends BaseHtmlComponent {
  Head(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super(
            key, 'head', id, className, style, props, eventListeners, children);
}

class Header extends BaseHtmlComponent {
  Header(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super(key, 'header', id, className, style, props, eventListeners,
            children);
}

class HR extends BaseHtmlComponent {
  HR(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners})
      : super(key, 'hr', id, className, style, props, eventListeners, [], true);
}

class Html extends BaseHtmlComponent {
  Html(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children,
      String manifest,
      String xmlns,
      String lang})
      : super(key, 'html', id, className, style, props, eventListeners,
            children) {
    this.props['manifest'] ??= manifest;
    this.props['xmlns'] ??= xmlns;
    this.props['lang'] ??= lang;
  }
}

class Footer extends BaseHtmlComponent {
  Footer(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super(key, 'footer', id, className, style, props, eventListeners,
            children);
}

class LI extends BaseHtmlComponent {
  LI(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super(key, 'li', id, className, style, props, eventListeners, children);
}

class Main extends BaseHtmlComponent {
  Main(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super(
            key, 'main', id, className, style, props, eventListeners, children);
}

class Meta extends BaseHtmlComponent {
  Meta(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children,
      String charset,
      String content,
      String httpEquiv,
      String name})
      : super(key, 'meta', id, className, style, props, eventListeners,
            children, true) {
    this.props['charset'] ??= charset;
    this.props['content'] ??= content;
    this.props['http-equiv'] ??= httpEquiv;
    this.props['name'] ??= name;
  }
}

class Nav extends BaseHtmlComponent {
  Nav(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super(
            key, 'nav', id, className, style, props, eventListeners, children);
}

class OList extends BaseHtmlComponent {
  OList(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super(key, 'ol', id, className, style, props, eventListeners, children);
}

class Paragraph extends BaseHtmlComponent {
  Paragraph(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super(key, 'p', id, className, style, props, eventListeners, children);
}

class Section extends BaseHtmlComponent {
  Section(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super(key, 'section', id, className, style, props, eventListeners,
            children);
}

class Span extends BaseHtmlComponent {
  Span(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super(
            key, 'span', id, className, style, props, eventListeners, children);
}

class UList extends BaseHtmlComponent {
  UList(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super(key, 'ul', id, className, style, props, eventListeners, children);
}
