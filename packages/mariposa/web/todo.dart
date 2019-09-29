// ignore_for_file: sdk_version_ui_as_code
import 'package:mariposa/browser.dart';
import 'package:mariposa/mariposa.dart';
import 'package:meta/meta.dart';
import 'package:universal_html/html.dart' hide Node, Text;
import 'todo_model.dart';

main() {
  return runMariposaApp(() => TodoApp(), querySelector('#app'));
}

class TodoApp extends ComponentClass {
  String inputText = '';
  var todos = <Todo>[];

  @override
  Node render() {
    return Div(children: [
      Heading.h1(
        child: Text('Todos (${todos.length})'),
      ),
      Heading.h3(
        child: Text('Current input text: $inputText'),
      ),
      if (todos.isEmpty) Text.italicized('No todos yet.'),
      if (todos.isNotEmpty)
        UList(
          children: todos.map((todo) {
            return TodoItem(todo, onDelete: () {
              setState(() => todos.remove(todo));
            });
          }),
        ),
      BR(),
      Text.italicized('Click a todo item to remove it.'),
      BR(),
      Input(
        placeholder: 'Add an entry...',
        value: inputText,
        onInput: (e) {
          setState(() => inputText = (e.target as InputElement).value);
        },
      ),
      Button(
        child: Text('Submit'),
        onClick: (_) {
          if (inputText.isNotEmpty) {
            setState(() {
              todos.add(Todo(inputText));
              inputText = '';
            });
          }
        },
      ),
    ]);
  }
}

class TodoItem extends ComponentClass {
  final Todo todo;
  final void Function() onDelete;

  TodoItem(this.todo, {@required this.onDelete});

  @override
  Node render() {
    return LI(
        children: [Text(todo.text)],
        eventListeners: {'click': (_) => onDelete()});
  }
}
