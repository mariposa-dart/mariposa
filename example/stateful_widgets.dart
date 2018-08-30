import 'dart:async';
import 'package:html_builder/elements.dart';
import 'package:html_builder/html_builder.dart';
import 'package:mariposa/mariposa.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _TodoListState();
  }
}

class _TodoListState extends State<TodoList> {
  String message = 'Getting todos...';

  @override
  void initState() {
    super.initState();
    new Future.delayed(const Duration(seconds: 2)).then((_) {
      setState(() {
        message = 'Got todos!';
      });
    });
  }

  @override
  Node render() {
    return Div(
      children: [
        Heading.h1(
          child: TextNode('Hi!'),
        ),
        Text.italicized('Hi!'),
      ],
    );
  }
}
