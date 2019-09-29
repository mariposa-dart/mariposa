import 'package:html_builder/html_builder.dart';
import 'package:universal_html/html.dart'
    show
        BodyElement,
        BRElement,
        DivElement,
        HeadElement,
        HRElement,
        HtmlHtmlElement,
        LIElement,
        MetaElement,
        OListElement,
        ParagraphElement,
        SpanElement,
        UListElement,
        Event;
import 'html_element.dart';

class Article extends Html5Component {
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

class Aside extends Html5Component {
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

class Body extends Html5Component<BodyElement> {
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

class BR extends Html5Component<BRElement> {
  BR(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners})
      : super(key, 'br', id, className, style, props, eventListeners, [], true);
}

class Div extends Html5Component<DivElement> {
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

class Head extends Html5Component<HeadElement> {
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

class Header extends Html5Component {
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

class HR extends Html5Component<HRElement> {
  HR(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners})
      : super(key, 'hr', id, className, style, props, eventListeners, [], true);
}

class Html extends Html5Component<HtmlHtmlElement> {
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

class Footer extends Html5Component {
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

class LI extends Html5Component<LIElement> {
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

class Main extends Html5Component {
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

class Meta extends Html5Component<MetaElement> {
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

class Nav extends Html5Component {
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

class OList extends Html5Component<OListElement> {
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

class Paragraph extends Html5Component<ParagraphElement> {
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

class Section extends Html5Component {
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

class Span extends Html5Component<SpanElement> {
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

class UList extends Html5Component<UListElement> {
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
