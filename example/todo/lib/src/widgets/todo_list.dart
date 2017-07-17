import 'package:html_builder/elements.dart';
import 'package:html_builder/html_builder.dart';
import '../models/todo.dart';
import 'todo_item.dart';

Node todoList(List<Todo> todos) => todos.isNotEmpty
    ? ul(p: {'data-is': 'todo-list'}, c: todos.map(todoItem))
    : i(c: [text('You have not added any todos yet!!!')]);
