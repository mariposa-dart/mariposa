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

  /// Triggered whenever attributes are to be applied to this instance. This occurs
  /// both on the initial render, and after updates.
  ///
  /// If you return a different [Map] from [newAttrs], then this node will be
  /// re-rendered. Note that the [Map] will not be compared deeply, so if you
  /// want to a re-render, you must explicitly return a new [Map].
  Map<String, dynamic> afterAttributeChange(
          Map<String, dynamic> oldAttrs, Map<String, dynamic> newAttrs) =>
      newAttrs;

  /// Triggered when a concrete node has been created for this component.
  ///
  /// [nativeElement] is available in this function.
  void afterMount() {}

  /// Triggered after the [nativeElement] has been destroyed.
  void afterUnmount() {}
}
