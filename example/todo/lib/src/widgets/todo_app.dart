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
      todoList(state['todos']),
      br(),
      input(
          type: 'text',
          placeholder: 'What do you have to do?',
          value: state.scope('input')['value'] ?? '')
    ]);
  }

  @override
  void afterRender(AbstractElement $el, State<List<Todo>> state) {
    var $input = $el.querySelector('input[type="text"]');

    $input.listen('change', (_) {
      // Note that the state change event happens before changing the value.
      //
      // State change events aren't processed until after calling afterRender.
      state.add('todos', new Todo($input.value));
      $input.value = '';
    });
  }
}
