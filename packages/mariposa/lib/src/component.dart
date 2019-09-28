import 'package:html_builder/html_builder.dart';

typedef Node Component();

abstract class ComponentClass {
  Node render();

  Node call() => render();

  void afterCreated() {}

  void beforeDestroyed() {}
}