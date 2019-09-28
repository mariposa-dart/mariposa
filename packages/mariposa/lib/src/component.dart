import 'package:html_builder/html_builder.dart';
import 'package:meta/meta.dart';
import 'render_context.dart';

typedef Node Component();

abstract class ComponentClass extends Node {
  final String key;

  ComponentClass({String tagName = 'div', this.key}) : super(tagName);

  RenderContext _context;

  RenderContext get context => _context;

  Node render();

  Node call() => render();

  @mustCallSuper
  void beforeRender(RenderContext context) {
    _context = context;
  }

  void afterMount() {}

  void afterUnmount() {}
}
