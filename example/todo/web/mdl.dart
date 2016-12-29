@JS()
library mdl;

import "package:js/js.dart";
import "dart:html" show HtmlElement, NodeList, HtmlCollection, Node;

/// Type definitions for material-design-lite v1.1.3
/// Project: https://getmdl.io
/// Definitions by: Brad Zacher <https://github.com/bradzacher/>
/// Definitions: https://github.com/DefinitelyTyped/DefinitelyTyped

// Module MaterialDesignLite
@anonymous
@JS()
abstract class ComponentHandler {
  /// Searches existing DOM for elements of our component type and upgrades them
  /// if they have not already been upgraded.
  /*external void upgradeDom();*/
  /// Searches existing DOM for elements of our component type and upgrades them
  /// if they have not already been upgraded.
  /// need to create a new instance of.
  /*external void upgradeDom(String jsClass);*/
  /// Searches existing DOM for elements of our component type and upgrades them
  /// if they have not already been upgraded.
  /// need to create a new instance of.
  /// type will have.
  /*external void upgradeDom(String jsClass, String cssClass);*/
  external void upgradeDom([String jsClass, String cssClass]);

  /// Upgrades a specific element rather than all in the DOM.
  /*external void upgradeElement(HtmlElement element);*/
  /// Upgrades a specific element rather than all in the DOM.
  /// the element to.
  /*external void upgradeElement(HtmlElement element, String jsClass);*/
  external void upgradeElement(HtmlElement element, [String jsClass]);

  /// Upgrades a specific list of elements rather than all in the DOM.
  /// The elements we wish to upgrade.
  /*external void upgradeElements(HtmlElement elements);*/
  /// Upgrades a specific list of elements rather than all in the DOM.
  /// The elements we wish to upgrade.
  /*external void upgradeElements(List<HtmlElement> elements);*/
  /// Upgrades a specific list of elements rather than all in the DOM.
  /// The elements we wish to upgrade.
  /*external void upgradeElements(NodeList elements);*/
  /// Upgrades a specific list of elements rather than all in the DOM.
  /// The elements we wish to upgrade.
  /*external void upgradeElements(HtmlCollection elements);*/
  external void upgradeElements(
      dynamic /*HtmlElement|List<HtmlElement>|NodeList|HtmlCollection*/ elements);

  /// Upgrades all registered components found in the current DOM. This is
  /// automatically called on window load.
  external void upgradeAllRegistered();

  /// Allows user to be alerted to any upgrades that are performed for a given
  /// component type
  /// to hook into for any upgrades performed.
  /// upgrade. This function should expect 1 parameter - the HTMLElement which
  /// got upgraded.
  external void registerUpgradedCallback(
      String jsClass, dynamic callback(HtmlElement element));

  /// Registers a class for future use and attempts to upgrade existing DOM.
  external void register(ComponentConfigPublic config);

  /// Downgrade either a given node, an array of nodes, or a NodeList.
  /*external void downgradeElements(Node nodes);*/
  /// Downgrade either a given node, an array of nodes, or a NodeList.
  /*external void downgradeElements(List<Node> nodes);*/
  /// Downgrade either a given node, an array of nodes, or a NodeList.
  /*external void downgradeElements(NodeList nodes);*/
  external void downgradeElements(dynamic /*Node|List<Node>|NodeList*/ nodes);
}

@anonymous
@JS()
abstract class ComponentConfigPublic {
  external void constructor(HtmlElement element);
  external String get classAsString;
  external set classAsString(String v);
  external String get cssClass;
  external set cssClass(String v);
  external dynamic /*String|bool*/ get widget;
  external set widget(dynamic /*String|bool*/ v);
}

// End module MaterialDesignLite
@JS()
external ComponentHandler get componentHandler;
@JS()
external set componentHandler(ComponentHandler v);

