import 'dart:html' show querySelector;
import 'package:html_builder/elements.dart';
import 'package:html_builder/html_builder.dart';
import 'package:mariposa/dom.dart' as mariposa_dom;
import 'package:mariposa/mariposa.dart';
import 'package:meta/meta.dart';

void main() {
  mariposa_dom.render(
    Greeting(message: 'Hello!'),
    querySelector('#app'),
  );
}

class Greeting extends Widget {
  final String message;

  Greeting({@required this.message});

  @override
  Node render() {
    return Text.b(message);
  }
}
