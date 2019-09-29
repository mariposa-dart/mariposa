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
  final Ref<InputElement> inputRef = Ref();
  String inputText = '';
  var todos = <Todo>[];

  @override
  void afterUnmount() => inputRef.close();

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
      Input<TextInputElement>(
        ref: inputRef,
        placeholder: 'Add an entry...',
        value: inputText,
        onInput: (e) {
          setState(() => inputText = inputRef.current.value);
        },
      ),
      Button(
        child: Text('Submit'),
        onClick: (_) {
          if (inputText.isNotEmpty) {
            setState(() {
              todos.add(Todo(inputText));
              inputRef.current?.value = inputText = '';
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
  // : super(key: todo.hashCode.toString());

  @override
  Node render() {
    // return Node('img', {'src': todo.text, 'style': 'max-height: 3em'});

    // // return Text.bold('wtf?');
    // return Image(src: todo.text, eventListeners: {'click': (_) => onDelete()});
    return LI(
        children: [Text(todo.text)],
        style: Style(color: 'blue'),
        eventListeners: {'click': (_) => onDelete()});
  }
}
