import 'package:html_builder/elements.dart';
import 'package:html_builder/html_builder.dart';
import 'package:mariposa/mariposa.dart';
import '../models/todo.dart';
import 'todo_list.dart';

class TodoApp extends Widget<List<Todo>> {
  Node textEntry(State state) {
    return form(
      className: 'ui form',
      c: [
        div(className: 'field', c: [
          div(
            className: 'ui left icon action input',
            c: [
              i(className: 'asterisk icon'),
              input(
                  type: 'text',
                  placeholder: 'What do you have to do?',
                  value: state['input.value'] ?? ''),
              button(
                  className: 'ui button',
                  c: [i(className: 'add icon'), text('Add')]),
            ],
          ),
        ]),
      ],
    );
  }

  @override
  Node render(State<List<Todo>> state) {
    return div(c: [
      div(
        className: 'ui menu',
        c: [
          div(className: 'ui header item', c: [
            text('Todos (${state.get("todos").length})'),
          ]),
        ],
      ),
      div(className: 'ui container', c: [
        textEntry(state),
        br(),
        new TodoList(state['todos']),
      ]),
    ]);
  }

  @override
  void afterRender(AbstractElement $el, State<List<Todo>> state) {
    var $form = $el.querySelector('form');
    var $input = $el.querySelector('input[type="text"]');
    var $button = $el.querySelector('button');

    void addTodo() {
      // Note that the state change event happens before changing the value.
      //
      // State change events aren't processed until after calling afterRender.
      state.add('todos', new Todo($input.value));
      $input.value = '';
    }

    $input.listen('keypress', (e) {
      if (e.keyCode != 13 || $input.value.isEmpty) return;
      addTodo();
    });

    $button.listen('click', (_) {
      if ($input.value.isEmpty) return;
      addTodo();
    });

    $form.listen('submit', (e) => e.preventDefault());
  }
}
