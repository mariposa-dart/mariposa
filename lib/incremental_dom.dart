@JS('IncrementalDOM')
library incremental_dom;

import 'dart:html';
import 'package:js/js.dart';

@JS()
external void elementOpen(String tagName, String id, List attributes);

@JS()
external Element elementClose(String tagName);

@JS()
external void elementVoid(String tagName, String id, List attributes);

@JS()
external void text(String text);

@JS()
external void patch(Element element, void callback());

@JS()
external Notifications get notifications;

abstract class Notifications {
  @JS()
  external void set nodesCreated(void callback(NodeList nodes));

  @JS()
  external void set nodesRemoved(void callback(NodeList nodes));
}