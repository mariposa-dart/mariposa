import 'package:html_builder/elements.dart';
import 'package:html_builder/html_builder.dart';
import '../models/todo.dart';
import 'todo_item.dart';

Node todoList(List<Todo> todos) =>
    ul(p: {'data-is': 'todo-list'}, c: todos.map(todoItem));
