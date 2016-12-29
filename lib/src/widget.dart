import 'vdom/vdom.dart' as vdom;
import 'state.dart';

abstract class Widget extends vdom.Node {
  final Map<String, dynamic> refs = {};
  State state;

  Widget({String tagName: 'div'}) : super(tagName);

  vdom.Node render();

  void afterRender($host) {}

  void beforeMount() {}

  void afterMount() {}

  void willReceiveAttrs(Map<String, dynamic> newAttrs) {}

  bool shouldUpdate() => true;

  void beforeUpdate() {}

  void afterUpdate() {}

  // Todo: setState, forceUpdate
}
