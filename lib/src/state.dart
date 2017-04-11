/// An abstract interface for safely managing application state.
abstract class State<T> {
  /// Retrieves the value of a given [key] within the state.
  T get(String key);

  /// Assigns, or re-assigns a value within the state.
  void set(String key, T value);

  /// Sets an immutable member within the state. This can never be re-assigned.
  void singleton(String key, T value);

  /// Returns a scoped [State] of values prefixed with a given key.
  State<U> scope<U>(String prefix);

  T operator [](String key) => get(key);

  void operator []=(String key, T value) {
    set(key, value);
  }
}
