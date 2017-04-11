import 'dart:async';
import 'state.dart';

class DefaultState<T> extends State<T> {
  bool _locked = false;
  StreamController<StateChangeInfo<T>> _onChange;

  final Map<String, T> data = {};
  final Map<String, T> singletons = {};
  final Map<String, DefaultState> scoped = {};
  final DefaultState<T> parent;

  Stream<StateChangeInfo<T>> get onChange => _onChange.stream;

  DefaultState([this.parent]);

  void lock() {
    _locked = true;
  }

  @override
  T get(String key) {
    if (singletons.containsKey(key))
      return singletons[key];
    else if (data.containsKey(key))
      return data[key];
    else if (parent != null)
      return parent.get(key);
    else
      return null;
  }

  @override
  State scope<U>(String prefix) => scoped.putIfAbsent(
      prefix, () => new DefaultState<U>());

  @override
  void set(String key, T value) {
    if (_locked)
      throw new StateError(
          'Cannot set "$key" to $value within an unmodifiable state.');
    else {
      _onChange.add(new StateChangeInfo<T>(key, value));
    }
  }

  @override
  void singleton(String key, T value) {
    if (_locked)
      throw new StateError(
          'Cannot set singleton "$key" to $value within an unmodifiable state.');
    else if (singletons.containsKey(key))
      throw new StateError('Cannot overwrite singleton "$key".');
    else
      singletons[key] = value;
  }
}

class StateChangeInfo<T> {
  final String key;
  final T value;

  StateChangeInfo(this.key, this.value);
}
