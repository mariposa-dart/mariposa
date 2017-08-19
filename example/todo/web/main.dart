import 'dart:html';
import 'package:mariposa/browser.dart';
import 'package:todo/todo.dart';

main() {
  runApp(
    querySelector('#app'),
    () => new TodoApp(),
    defaultState: defaultState,
  );
}

Map<String, dynamic> defaultState() => {'todos': []};
