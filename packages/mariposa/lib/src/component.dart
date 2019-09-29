import 'package:html_builder/html_builder.dart';
import 'package:meta/meta.dart';
import 'package:universal_html/html.dart' show Element;
import 'render_context.dart';

typedef Node Component();

const String mariposaKey = 'data-mariposa-key';

abstract class ComponentClass<T extends Element> extends Node {
  final String key;

  Map<String, dynamic> _lastProps;
  Element rawNativeElement;

  ComponentClass({String tagName = 'div', this.key}) : super(tagName);

  T get nativeElement => rawNativeElement as T;

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
