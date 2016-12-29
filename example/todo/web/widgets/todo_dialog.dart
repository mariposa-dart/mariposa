import 'dart:async';
import 'package:mariposa/mariposa.dart';
import '../todo.dart';

class TodoDialogWidget extends Widget {
  final StreamController<Todo> _onSubmit = new StreamController<Todo>();
  Stream<Todo> get onSubmit => _onSubmit.stream;

  @override
  render() {
    
  }
}