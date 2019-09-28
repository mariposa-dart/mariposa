import 'package:html_builder/html_builder.dart';
import 'package:universal_html/html.dart' show Event;
import 'html_element.dart';

class Article extends BaseHtmlComponent {
  Article(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super('article', id, className, style, props, eventListeners, children);
}

class Aside extends BaseHtmlComponent {
  Aside(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super('aside', id, className, style, props, eventListeners, children);
}

class Body extends BaseHtmlComponent {
  Body(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super('body', id, className, style, props, eventListeners, children);
}

class BR extends BaseHtmlComponent {
  BR(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners})
      : super('br', id, className, style, props, eventListeners, [], true);
}

class Div extends BaseHtmlComponent {
  Div(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super('div', id, className, style, props, eventListeners, children);
}

class Head extends BaseHtmlComponent {
  Head(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super('head', id, className, style, props, eventListeners, children);
}

class Header extends BaseHtmlComponent {
  Header(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super('header', id, className, style, props, eventListeners, children);
}

class HR extends BaseHtmlComponent {
  HR(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners})
      : super('hr', id, className, style, props, eventListeners, [], true);
}

class Html extends BaseHtmlComponent {
  Html(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children,
      String manifest,
      String xmlns,
      String lang})
      : super('html', id, className, style, props, eventListeners, children) {
    this.props['manifest'] ??= manifest;
    this.props['xmlns'] ??= xmlns;
    this.props['lang'] ??= lang;
  }
}

class Footer extends BaseHtmlComponent {
  Footer(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super('footer', id, className, style, props, eventListeners, children);
}

class LI extends BaseHtmlComponent {
  LI(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super('li', id, className, style, props, eventListeners, children);
}

class Main extends BaseHtmlComponent {
  Main(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super('main', id, className, style, props, eventListeners, children);
}

class Meta extends BaseHtmlComponent {
  Meta(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children,
      String charset,
      String content,
      String httpEquiv,
      String name})
      : super('meta', id, className, style, props, eventListeners, children,
            true) {
    this.props['charset'] ??= charset;
    this.props['content'] ??= content;
    this.props['http-equiv'] ??= httpEquiv;
    this.props['name'] ??= name;
  }
}

class Nav extends BaseHtmlComponent {
  Nav(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super('nav', id, className, style, props, eventListeners, children);
}

class OList extends BaseHtmlComponent {
  OList(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super('ol', id, className, style, props, eventListeners, children);
}

class Paragraph extends BaseHtmlComponent {
  Paragraph(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super('p', id, className, style, props, eventListeners, children);
}

class Section extends BaseHtmlComponent {
  Section(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super('section', id, className, style, props, eventListeners, children);
}

class Span extends BaseHtmlComponent {
  Span(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super('span', id, className, style, props, eventListeners, children);
}

class UList extends BaseHtmlComponent {
  UList(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super('ul', id, className, style, props, eventListeners, children);
}
