import 'package:html_builder/elements.dart';
import 'package:html_builder/html_builder.dart';
import '../models/todo.dart';

String todoItemClass(bool completed) =>
    completed == true ? 'todo_item--complete' : 'todo_item--incomplete';

Node todoItem(Todo todo) =>
    li(className: todoItemClass(todo.completed), c: [text(todo.text)]);
