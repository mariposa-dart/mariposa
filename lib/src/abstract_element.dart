import 'dart:async';

/// A read-only abstraction over a DOM element.
///
/// In practice, this may not be an actual DOM element at all.
/// Hooray, it's isomorphic!
abstract class AbstractElement<T> {
  /// The children of this element.
  Iterable<AbstractElement<T>> get children;

  /// This element's parent, if any.
  AbstractElement<T> get parent;

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
  AbstractElement<T> querySelector(String selectors);

  /// Returns all children of this element matching the given [selectors].
  Iterable<AbstractElement<T>> querySelectorAll(String selectors);

  /// Attaches a callback function to a specific event.
  ///
  /// This callback will be disposed automatically by [close].
  void listen<U extends T>(String eventName, void callback(U event));

  /// Closes any event listeners on this element.
  Future close();
}