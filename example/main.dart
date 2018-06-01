import 'dart:html' hide Node;
import 'package:html_builder/elements.dart';
import 'package:html_builder/html_builder.dart';
import 'package:mariposa/dom.dart' as mariposa_dom;

Node greeting({String message}) => b(c: [text(message)]);

void main() {
  mariposa_dom.render(
    () => greeting(message: 'Hello!'),
    querySelector('#app'),
  );
}
