/// Mariposa bindings to `package:immutable_state`.
library mariposa.immutable_state;

import 'dart:async';
import 'package:immutable_state/immutable_state.dart';
import 'package:mariposa/mariposa.dart';
import 'package:meta/meta.dart' hide Immutable;

class ImmutableManager<T> extends ComponentClass {
  final Immutable<T> immutable;
  final Node child;
  StreamSubscription<T> _onChange;

  ImmutableManager({@required T initialValue, @required this.child, String key})
      : immutable = Immutable(initialValue),
        super(key: key);

  ImmutableManager.from(
      {@required this.immutable, @required this.child, String key})
      : super(key: key);

  @override
  void afterMount() {
    _onChange = immutable.onChange.listen((value) {
      setState(() => null);
    });
  }

  @override
  void afterUnmount() {
    _onChange?.cancel();
    immutable.close();
  }

  @override
  Node render() => child;
}

/// A wrapper around [ImmutableManager] that maps to a property.
class ImmutablePropertyManager<T, U> extends ComponentClass {
  final U Function(T) current;
  final T Function(T, U) change;
  final Node child;

  //final Widget Function(BuildContext, Immutable<U>) builder;

  ImmutablePropertyManager(
      {String key, @required this.current, @required this.child, this.change})
      : super(key: key);

  @override
  Node render() {
    return ImmutableView<T>(
      builder: (state) {
        return ImmutableManager.from(
          immutable: state.property(current, change: change),
          child: child,
        );
      },
    );
  }
}

class ImmutableView<T> extends ComponentClass {
  final Node Function(Immutable<T>) builder;

  ImmutableView({@required this.builder, String key}) : super(key: key);

  /// Creates an [ImmutableView] that only accesses the current value,
  /// and is guaranteed to never update the [Immutable].
  factory ImmutableView.readOnly(
          {@required Node Function(T) builder, String key}) =>
      ImmutableView<T>(builder: (state) => builder(state.current), key: key);

  @override
  Node render() {
    var manager = context.findParentOfType<ImmutableManager<T>>();
    if (manager == null) {
      throw StateError(
          'This widget does not inherit from an ImmutableManager<$T>, but ImmutableView<$T> was used.');
    }
    return builder(manager.immutable);
  }
}
