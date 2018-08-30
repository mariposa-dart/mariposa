import 'package:html_builder/html_builder.dart';
import 'abstract_element.dart';

const String mariposaStampKey = 'data-mariposa-stamp-key';

/// A [Node] that can access the state of the DOM or virtual DOM tree.
abstract class Widget extends Node {
  Widget({String tagName}) : super(tagName ?? 'div');

  /// Produces an HTML AST representing  this widget.
  Node render();

  /// A callback function run after this widget is rendered into a DOM node.
  void afterRender(AbstractElement element) {}

  /// A callback function run after this widget's corresponding node is destroyed.
  void beforeDestroy(AbstractElement element) {}
}
