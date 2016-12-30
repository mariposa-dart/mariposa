import 'dart:async';

// final RegExp _symbol = new RegExp(r'Symbol\("([^"]+)"\)');

@proxy
class State {
  final Map<String, dynamic> _data;
  final StreamController<StateUpdateEvent> _onUpdate =
      new StreamController<StateUpdateEvent>();

  Stream<StateUpdateEvent> get onUpdate => _onUpdate.stream;

  State() : _data = new Map<String, dynamic>.unmodifiable({});

  State.fromMap(Map<String, dynamic> data)
      : _data = new Map<String, dynamic>.unmodifiable(data);

  operator [](String key) => get(key);

  get(String key) => _data[key];

  void set(String key, value) {
    var newState = new Map.unmodifiable(new Map.from(_data)..[key] = value);
    _onUpdate.add(new StateUpdateEvent(key, value, _data, newState));
  }

  Map<String, dynamic> dump() => _data;

  void increment(String key) {
    set(key, (get(key) ?? 0) + 1);
  }

  /**
  @override
  noSuchMethod(Invocation invocation) {
    if (invocation.isGetter || invocation.isAccessor) {
      final match = _symbol.firstMatch(invocation.memberName.toString());

      if (match != null) return get(match.group(1));
    }
  }
  */
}

class StateUpdateEvent {
  final String key;
  final value;
  final Map<String, dynamic> oldState, newState;

  StateUpdateEvent(this.key, this.value, this.oldState, this.newState);
}
