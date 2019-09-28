@JS('IncrementalDOM')
library incremental_dom;

import 'dart:html';
import 'package:js/js.dart';

@JS()
external void elementOpen(String tagName, String id, List attributes);

@JS()
external Element elementClose(String tagName);

@JS()
external Element elementVoid(String tagName, String id, List attributes);

@JS()
external Text text(String text);

@JS()
external void patch(Element element, void callback());

@JS()
external Notifications get notifications;

@JS()
@anonymous
abstract class Notifications {
  @JS()
  external void Function(NodeList) get nodesCreated;

  @JS()
  external void Function(NodeList) get nodesDeleted;

  @JS()
  external set nodesCreated(void Function(NodeList) callback);

  @JS()
  external set nodesDeleted(void Function(NodeList) callback);
}
