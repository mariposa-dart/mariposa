import 'dart:async';
import 'vdom/vdom.dart' as vdom;
import 'state.dart';

abstract class Widget extends vdom.Node {
  final StreamController _onRender = new StreamController.broadcast();
  Stream get onRender => _onRender.stream;

  State state;

  Widget({String tagName: 'div'}) : super(tagName);

  vdom.Node render();

  void add(vdom.Node node) => children.add(node);

  void afterRender($host) {}

  void beforeMount() {}

  void afterMount() {}

  void willReceiveAttrs(Map<String, dynamic> newAttrs) {}

  bool shouldUpdate(
          Map<String, dynamic> oldState, Map<String, dynamic> newState) =>
      true;

  void beforeUpdate() {}

  void afterUpdate() {}

  // Todo: setState, forceUpdate
}
