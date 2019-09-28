import 'dart:async';

abstract class IncrementalDom<T> {
  Stream<T> get onNodeCreated;
  Stream<T> get onNodeDeleted;
  Future<void> close();

  void elementOpen(String tagName, String id, Map<String, dynamic> attributes);

  T elementClose(String tagName);

  T elementVoid(String tagName, String id, Map<String, dynamic> attributes);

  void text(String text);

  void patch(T element, void callback());
}
