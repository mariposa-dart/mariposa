import 'dart:html' hide Node;
import 'package:html_builder/html_builder.dart';
import 'state.dart';

/// TODO: Lifecycle
abstract class Widget<T> extends Node {
  Widget() : super('div');

  /// Determines if a change in state should trigger a re-rendering of this widget.
  bool shouldUpdate(State<T> prevState, State<T> newState) => true;

  /// Produces an HTML AST representing the [state] of this widget.
  Node render(State<T> state);

  void afterRender(HtmlElement $el, State<T> state) {

  }
}
