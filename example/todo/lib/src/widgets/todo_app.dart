import 'dart:html' hide Node;
import 'package:html_builder/elements.dart';
import 'package:html_builder/html_builder.dart';
import 'package:mariposa/mariposa.dart';
import '../models/todo.dart';
import 'todo_list.dart';

class TodoApp extends Widget<List<Todo>> {
  @override
  Node render(State<List<Todo>> state) {
    return div(c: [
      h1(c: [text('Todos (${state.get("todos").length})')]),
      todoList(state['todos'])
    ]);
  }

  @override
  void afterRender(HtmlElement $el, State<List<Todo>> state) {
    $el.onClick.listen((_) {
      state.set('todos', []);
    });
  }
}
