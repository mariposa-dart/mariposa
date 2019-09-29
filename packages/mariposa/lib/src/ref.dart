part of 'component.dart';

class Ref<T> {
  final StreamController<T> _onChange = StreamController();
  T _current;

  T get current => _current;

  Stream<T> get onChange => _onChange.stream;

  Future<void> close() {
    _onChange.close();
    return Future.value();
  }

  void _set(T value) {
    _onChange.add(_current = value);
  }
}
