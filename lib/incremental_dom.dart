@JS('IncrementalDOM')
library incremental_dom;

import 'dart:html';
import 'package:js/js.dart';

@JS()
external void elementOpen(String tagName, String id, List<String> attributes);

@JS()
external Element elementClose(String tagName);

@JS()
external void elementVoid(String tagName, String id, List<String> attributes);

@JS()
external void text(String text);

@JS()
external void patch(Element element, void callback());