import 'dart:async';

abstract class IncrementalDom<NodeType, ElementType extends NodeType> {
  Stream<NodeType> get onNodeCreated;
  Stream<NodeType> get onNodeDeleted;
  Future<void> close();

  void elementOpen(String tagName, String id, Map<String, dynamic> attributes);

  ElementType elementClose(String tagName);

  ElementType elementVoid(
      String tagName, String id, Map<String, dynamic> attributes);

  void text(String text);

  void patch(ElementType element, void callback());
}
