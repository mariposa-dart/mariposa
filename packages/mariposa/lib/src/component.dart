import 'dart:async';
import 'package:html_builder/html_builder.dart';
import 'package:meta/meta.dart';
import 'package:universal_html/html.dart' show Element;
import 'render_context.dart';
part 'ref.dart';

typedef Node Component();

const String mariposaKey = 'data-mariposa-key';

abstract class ComponentClass<T extends Element> extends Node {
  final String key;
  final void Function(T) onMount;

  Map<String, dynamic> _lastProps;

  Element _rawNativeElement;

  ComponentClass(
      {String tagName = 'div', this.key, void Function(T) onMount, Ref<T> ref})
      : this.onMount = onMount ?? ref?._set,
        super(tagName);

  T get nativeElement => _rawNativeElement as T;

  set rawNativeElement(Element value) {
    _rawNativeElement = value;
    if (onMount != null) onMount(nativeElement);
  }

  RenderContext _context;

  RenderContext get context => _context;

  Node render();

  Node call() => render();

  void setState(void Function() callback) {
    callback();
    context.triggerUpdate();
  }

  @mustCallSuper
  void beforeRender(RenderContext context) {
    _context = context;
  }

  @mustCallSuper
  Map<String, dynamic> handleAttributesFromRender(Map<String, dynamic> attrs) {
    return _lastProps = afterAttributeChange(_lastProps, attrs);
  }

  Map<String, dynamic> afterAttributeChange(
          Map<String, dynamic> oldAttrs, Map<String, dynamic> newAttrs) =>
      newAttrs;

  void afterMount() {}

  void afterUnmount() {}
}
