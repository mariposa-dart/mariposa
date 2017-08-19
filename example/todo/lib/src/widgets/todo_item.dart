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
    return div(
      className: 'item',
      c: [
        div(className: 'right floated content', c: [
          button(className: 'ui negative button', c: [
            i(className: 'delete icon'),
            text('Delete'),
          ]),
        ]),
        div(
          className: 'main content',
          c: [text(todo.text)],
        ),
      ],
    );
  }

  @override
  void afterRender(AbstractElement $element, State state) {
    var $content = $element.querySelector('.main.content');
    var $button = $element.querySelector('button');

    $content.listen('click', (_) {
      state.notify(() {
        todo.completed = !todo.completed;
      });
    });

    $button.listen('click', (_) {
      state.notify(() {
        state['todos'].remove(todo);
      });
    });
  }
}
