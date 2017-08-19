import 'package:html_builder/html_builder.dart';
import 'package:meta/meta.dart';
import 'state.dart';
import 'widget.dart';

abstract class StatefulWidget<T> extends Widget<T> {
  @mustCallSuper
  StatefulWidget();

  WidgetState<T> createState();

  @override
  Node render(State<T> state) {
    return createState().render(state);
  }
}

abstract class WidgetState<T> {
  Node render(State<T> state);
}