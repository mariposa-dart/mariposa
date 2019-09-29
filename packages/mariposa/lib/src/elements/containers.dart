import 'package:html_builder/html_builder.dart';
import 'package:universal_html/html.dart'
    show
        BodyElement,
        BRElement,
        DivElement,
        Element,
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
      void Function(Element) onMount,
      Ref<Element> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super.bare(key, 'article', id, className, style, onMount, ref, props,
            eventListeners, children);
}

class Aside extends Html5Component {
  Aside(
      {String key,
      String id,
      className,
      Style style,
      void Function(Element) onMount,
      Ref<Element> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super.bare(key, 'aside', id, className, style, onMount, ref, props,
            eventListeners, children);
}

class Body extends Html5Component<BodyElement> {
  Body(
      {String key,
      String id,
      className,
      Style style,
      void Function(BodyElement) onMount,
      Ref<BodyElement> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super.bare(key, 'body', id, className, style, onMount, ref, props,
            eventListeners, children);
}

class BR extends Html5Component<BRElement> {
  BR(
      {String key,
      String id,
      className,
      Style style,
      void Function(BRElement) onMount,
      Ref<BRElement> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners})
      : super.bare(key, 'br', id, className, style, onMount, ref, props,
            eventListeners, [], true);
}

class Div extends Html5Component<DivElement> {
  Div(
      {String key,
      String id,
      className,
      Style style,
      void Function(DivElement) onMount,
      Ref<DivElement> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super.bare(key, 'div', id, className, style, onMount, ref, props,
            eventListeners, children);
}

class Head extends Html5Component<HeadElement> {
  Head(
      {String key,
      String id,
      className,
      Style style,
      void Function(HeadElement) onMount,
      Ref<HeadElement> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super.bare(key, 'head', id, className, style, onMount, ref, props,
            eventListeners, children);
}

class Header extends Html5Component {
  Header(
      {String key,
      String id,
      className,
      Style style,
      void Function(Element) onMount,
      Ref<Element> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super.bare(key, 'header', id, className, style, onMount, ref, props,
            eventListeners, children);
}

class HR extends Html5Component<HRElement> {
  HR(
      {String key,
      String id,
      className,
      Style style,
      void Function(HRElement) onMount,
      Ref<HRElement> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners})
      : super.bare(key, 'hr', id, className, style, onMount, ref, props,
            eventListeners, [], true);
}

class Html extends Html5Component<HtmlHtmlElement> {
  Html(
      {String key,
      String id,
      className,
      Style style,
      void Function(HtmlHtmlElement) onMount,
      Ref<HtmlHtmlElement> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children,
      String manifest,
      String xmlns,
      String lang})
      : super.bare(key, 'html', id, className, style, onMount, ref, props,
            eventListeners, children) {
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
      void Function(Element) onMount,
      Ref<Element> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super.bare(key, 'footer', id, className, style, onMount, ref, props,
            eventListeners, children);
}

class LI extends Html5Component<LIElement> {
  LI(
      {String key,
      String id,
      className,
      Style style,
      void Function(LIElement) onMount,
      Ref<LIElement> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super.bare(key, 'li', id, className, style, onMount, ref, props,
            eventListeners, children);
}

class Main extends Html5Component {
  Main(
      {String key,
      String id,
      className,
      Style style,
      void Function(Element) onMount,
      Ref<Element> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super.bare(key, 'main', id, className, style, onMount, ref, props,
            eventListeners, children);
}

class Meta extends Html5Component<MetaElement> {
  Meta(
      {String key,
      String id,
      className,
      Style style,
      void Function(MetaElement) onMount,
      Ref<MetaElement> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children,
      String charset,
      String content,
      String httpEquiv,
      String name})
      : super.bare(key, 'meta', id, className, style, onMount, ref, props,
            eventListeners, children, true) {
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
      void Function(Element) onMount,
      Ref<Element> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super.bare(key, 'nav', id, className, style, onMount, ref, props,
            eventListeners, children);
}

class OList extends Html5Component<OListElement> {
  OList(
      {String key,
      String id,
      className,
      Style style,
      void Function(OListElement) onMount,
      Ref<OListElement> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super.bare(key, 'ol', id, className, style, onMount, ref, props,
            eventListeners, children);
}

class Paragraph extends Html5Component<ParagraphElement> {
  Paragraph(
      {String key,
      String id,
      className,
      Style style,
      void Function(ParagraphElement) onMount,
      Ref<ParagraphElement> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super.bare(key, 'p', id, className, style, onMount, ref, props,
            eventListeners, children);
}

class Section extends Html5Component {
  Section(
      {String key,
      String id,
      className,
      Style style,
      void Function(Element) onMount,
      Ref<Element> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super.bare(key, 'section', id, className, style, onMount, ref, props,
            eventListeners, children);
}

class Span extends Html5Component<SpanElement> {
  Span(
      {String key,
      String id,
      className,
      Style style,
      void Function(SpanElement) onMount,
      Ref<SpanElement> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super.bare(key, 'span', id, className, style, onMount, ref, props,
            eventListeners, children);
}

class UList extends Html5Component<UListElement> {
  UList(
      {String key,
      String id,
      className,
      Style style,
      void Function(UListElement) onMount,
      Ref<UListElement> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children})
      : super.bare(key, 'ul', id, className, style, onMount, ref, props,
            eventListeners, children);
}
