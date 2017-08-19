import 'dart:async';
import 'state.dart';

class StateImpl<T> extends State<T> {
  bool _locked = false;
  final StreamController<StateChangeInfo<T>> _onChange =
      new StreamController<StateChangeInfo<T>>(
    sync: true,
  );

  final Map<String, T> data = {};
  final Map<String, T> singletons = {};
  final Map<String, StateImpl> scoped = {};
  final StateImpl<T> parent;
  final bool bubble;

  Stream<StateChangeInfo<T>> get onChange => _onChange.stream;

  StateImpl([this.parent, this.bubble]);

  void close() {
    scoped.values.forEach((s) => s.close());
    _onChange.close();
  }

  void lock() {
    _locked = true;
  }

  @override
  void notify(void callback()) {
    callback();
    _onChange.add(new _StateChangeInfoImpl(null, null));
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
  State<U> scope<U>(String prefix) {
    return null;
    /*
    return scoped.putIfAbsent(
      prefix,
      () => _scope(prefix),
      // TODO: How the hell do I make this DDC-compatible?
    );
    */
  }

  State<dynamic> _scope(String prefix) {
    var child = new StateImpl(this, bubble);

    if (bubble == true) {
      child.onChange.listen((info) {
        _onChange
            .add(new _StateChangeInfoImpl('$prefix.${info.key}', info.value));
      });
    }

    return child as State<dynamic>;
  }

  @override
  void set(String key, T value) {
    if (_locked && false)
      throw new StateError(
          'Cannot set "$key" to $value within an unmodifiable state.');
    else {
      _onChange.add(new _StateChangeInfoImpl<T>(key, value));
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

class _StateChangeInfoImpl<T> implements StateChangeInfo<T> {
  @override
  final String key;

  @override
  final T value;

  _StateChangeInfoImpl(this.key, this.value);
}
