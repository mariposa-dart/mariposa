import 'dart:async';


/// An abstract interface for safely managing application state.
abstract class State<T> {
  /// Fires when a value is changed.
  Stream<StateChangeInfo<T>> get onChange;

  /// Retrieves the value of a given [key] within the state.
  T get(String key);

  /// Assigns, or re-assigns a value within the state.
  void set(String key, T value);

  /// Sets an immutable member within the state. This can never be re-assigned.
  void singleton(String key, T value);

  /// Returns a scoped [State] of values prefixed with a given key.
  State<U> scope<U>(String prefix);

  /// Adds a value to the list identified by [key].
  void add(String key, value) {
    dynamic v = new List.from(get(key) as Iterable)..add(value);
    set(key, v as T);
  }

  T operator [](String key) => get(key);

  void operator []=(String key, T value) {
    set(key, value);
  }
}

abstract class StateChangeInfo<T> {
  String get key;
  T get value;
}