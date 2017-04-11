import 'package:html_builder/elements.dart';
import 'package:html_builder/html_builder.dart';
import 'package:mariposa/mariposa.dart';
import '../models/todo.dart';
import 'todo_item.dart';

class TodoList extends Widget<List<Todo>> {
  @override
  Node render(State<List<Todo>> state) =>
      ul(children: state.get('todos').map(todoItem));
}
