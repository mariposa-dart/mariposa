import 'dart:html';
import 'package:mariposa/mariposa.dart';
import 'package:mariposa/dom.dart';
import 'widgets/app.dart';
import 'todo.dart';

main() {
  MARIPOSA
    ..onUpdate.listen(TIME_TRAVEL)
    ..onUpdate.listen((e) {
      document.title = e.newState['title'] ?? 'Todos';
    })
    ..render(new AppWidget(), querySelector('#app'), initialState: {
      'title': document.title = 'Todos',
      'todos': <Todo>[new Todo(title: 'Hello, world!')]
    });
}
