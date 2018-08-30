import 'package:html_builder/html_builder.dart';
import 'html_element.dart';

class Article extends HtmlWidget {
  Article(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
      Iterable<Node> children})
      : super('article', id, className, style, props, eventListeners, children);
}

class Aside extends HtmlWidget {
  Aside(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
      Iterable<Node> children})
      : super('aside', id, className, style, props, eventListeners, children);
}

class Body extends HtmlWidget {
  Body(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
      Iterable<Node> children})
      : super('body', id, className, style, props, eventListeners, children);
}

class BR extends HtmlWidget {
  BR(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners})
      : super('br', id, className, style, props, eventListeners, [], true);
}

class Div extends HtmlWidget {
  Div(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
      Iterable<Node> children})
      : super('div', id, className, style, props, eventListeners, children);
}

class Head extends HtmlWidget {
  Head(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
      Iterable<Node> children})
      : super('head', id, className, style, props, eventListeners, children);
}

class Header extends HtmlWidget {
  Header(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
      Iterable<Node> children})
      : super('header', id, className, style, props, eventListeners, children);
}

class HR extends HtmlWidget {
  HR(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners})
      : super('hr', id, className, style, props, eventListeners, [], true);
}

class Html extends HtmlWidget {
  Html(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
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

class Footer extends HtmlWidget {
  Footer(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
      Iterable<Node> children})
      : super('footer', id, className, style, props, eventListeners, children);
}

class LI extends HtmlWidget {
  LI(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
      Iterable<Node> children})
      : super('li', id, className, style, props, eventListeners, children);
}

class Main extends HtmlWidget {
  Main(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
      Iterable<Node> children})
      : super('main', id, className, style, props, eventListeners, children);
}

class Meta extends HtmlWidget {
  Meta(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
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

class Nav extends HtmlWidget {
  Nav(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
      Iterable<Node> children})
      : super('nav', id, className, style, props, eventListeners, children);
}

class OList extends HtmlWidget {
  OList(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
      Iterable<Node> children})
      : super('ol', id, className, style, props, eventListeners, children);
}

class Paragraph extends HtmlWidget {
  Paragraph(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
      Iterable<Node> children})
      : super('p', id, className, style, props, eventListeners, children);
}

class Section extends HtmlWidget {
  Section(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
      Iterable<Node> children})
      : super('section', id, className, style, props, eventListeners, children);
}

class Span extends HtmlWidget {
  Span(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
      Iterable<Node> children})
      : super('span', id, className, style, props, eventListeners, children);
}

class UList extends HtmlWidget {
  UList(
      {String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
      Iterable<Node> children})
      : super('ul', id, className, style, props, eventListeners, children);
}
