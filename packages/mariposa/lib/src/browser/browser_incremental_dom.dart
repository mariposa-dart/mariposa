import 'dart:async';
import 'dart:html';
import 'package:mariposa/mariposa.dart';
import 'js_incremental_dom.dart' as js_idom;

class BrowserIncrementalDom extends IncrementalDom<Node, Element> {
  final StreamController<Node> _onNodeCreated = StreamController(),
      _onNodeDeleted = StreamController();

  void Function(NodeList) _oldNodesCreated, _oldNodesDeleted;

  @override
  Stream<Node> get onNodeCreated => _onNodeCreated.stream;

  @override
  Stream<Node> get onNodeDeleted => _onNodeDeleted.stream;

  BrowserIncrementalDom() {
    _oldNodesCreated = js_idom.notifications.nodesCreated;
    _oldNodesDeleted = js_idom.notifications.nodesDeleted;
    js_idom.notifications.nodesCreated =
        (nodes) => nodes.forEach(_onNodeCreated.add);
    js_idom.notifications.nodesDeleted =
        (nodes) => nodes.forEach(_onNodeDeleted.add);
  }

  @override
  Future<void> close() {
    _onNodeCreated.close();
    _onNodeDeleted.close();
    js_idom.notifications
      ..nodesCreated = _oldNodesCreated
      ..nodesDeleted = _oldNodesDeleted;
    return Future.value();
  }

  List listifyAttributes(Map<String, dynamic> m) {
    return m.entries.fold([], (out, entry) {
      return out..addAll([entry.key, entry.value]);
    });
  }

  @override
  Element elementClose(String tagName) => js_idom.elementClose(tagName);

  @override
  void elementOpen(
          String tagName, String id, Map<String, dynamic> attributes) =>
      js_idom.elementOpen(tagName, id, listifyAttributes(attributes));

  @override
  Element elementVoid(
          String tagName, String id, Map<String, dynamic> attributes) =>
      js_idom.elementVoid(tagName, id, listifyAttributes(attributes));

  @override
  void patch(Element element, void Function() callback) =>
      js_idom.patch(element, callback);

  @override
  void text(String text) => js_idom.text(text);
}
