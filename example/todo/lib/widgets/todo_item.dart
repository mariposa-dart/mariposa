import 'package:html_builder/elements.dart';
import 'package:html_builder/html_builder.dart';
import '../models/todo.dart';

Node todoItem(Todo todo) => li(
    className: todo.completed == true
        ? 'todo_item--complete'
        : 'todo_item--incomplete',
    children: [text(todo.text)]);