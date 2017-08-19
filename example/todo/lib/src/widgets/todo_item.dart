import 'package:html_builder/elements.dart';
import 'package:html_builder/html_builder.dart';
import '../models/todo.dart';
import 'package:mariposa/mariposa.dart';

String todoItemClass(bool completed) {
  return completed == true ? 'todo_item--complete' : 'todo_item--incomplete';
}

class TodoItem extends Widget {
  final Todo todo;

  TodoItem(this.todo);

  @override
  Node render(State state) {
    return li(
      className: todoItemClass(todo.completed),
      c: [
        text(todo.text),
      ],
    );
  }

  @override
  void afterRender(AbstractElement $element, State state) {
    $element.listen('click', (_) {
      state.notify(() {
        todo.completed = !todo.completed;
      });
    });
  }
}
