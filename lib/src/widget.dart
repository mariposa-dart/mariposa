import 'package:html_builder/html_builder.dart';
import 'abstract_element.dart';
import 'state.dart';

/// TODO: Lifecycle
abstract class Widget<T> extends Node {
  Widget() : super('div');

  /// Determines if a change in state should trigger a re-rendering of this widget.
  bool shouldUpdate(State<T> prevState, State<T> newState) => true;

  /// Produces an HTML AST representing the [state] of this widget.
  Node render(State<T> state);

  /// A callback function run after this widget is rendered into a DOM node.
  void afterRender(AbstractElement $element, State<T> state) {}
}
