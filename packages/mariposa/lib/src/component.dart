import 'package:html_builder/html_builder.dart';
import 'package:meta/meta.dart';
import 'package:universal_html/html.dart' show Element;
import 'render_context.dart';

typedef Node Component();

const String mariposaKey = 'data-mariposa-key';

abstract class ComponentClass extends Node {
  final String key;
  Object rawNativeElement;

  ComponentClass({String tagName = 'div', this.key}) : super(tagName);

  Element get nativeElement => rawNativeElement as Element;

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

  void afterMount() {}

  void afterUnmount() {}
}
