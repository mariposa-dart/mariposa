import 'dart:async';

/// A read-only abstraction over a DOM element.
///
/// In practice, this may not be an actual DOM element at all.
/// Hooray, it's isomorphic!
abstract class AbstractElement {
  /// The children of this element.
  Iterable<AbstractElement> get children;

  /// This element's parent, if any.
  AbstractElement get parent;

  /// The value of this element, if it is an input.
  ///
  /// Otherwise, this will be the same as calling [getAttribute] with the argument `'value'`.
  String get value;

  /// Sets the value of this element, if it is an input.
  ///
  /// Otherwise, this will be the same as calling [setAttribute] with the argument `'value'`.
  void set value(String value);

  /// The values of all attributes on this element.
  Map<String, String> get attributes;

  /// Returns the first child of this element matching the given [selectors], or `null`.
  AbstractElement querySelector(String selectors);

  /// Returns all children of this element matching the given [selectors].
  Iterable<AbstractElement> querySelectorAll(String selectors);

  /// Attaches a callback function to a specific event.
  ///
  /// This callback will be disposed automatically by [close].
  void listen<T>(String eventName, void callback(T event));

  /// Closes any event listeners on this element.
  Future close();
}