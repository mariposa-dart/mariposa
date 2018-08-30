import 'dart:collection';
import 'package:angel_container/angel_container.dart';
import 'render_context.dart';
import 'stateful_widget.dart';

class RenderContextImpl implements RenderContext {
  Map<StatefulWidget, State> states;
  final Queue<void Function(RenderContext)> tasks = new Queue();
  Container _container;

  final RenderContextImpl _parent;

  RenderContextImpl(Reflector reflector)
      : _container = new Container(reflector),
        _parent = null {
    container.registerSingleton<Map<StatefulWidget, State>>(states = {});
  }

  RenderContextImpl._child(this._parent)
      : _container = _parent.container.createChild();

  Container get container => _container;

  @override
  RenderContextImpl createChild() {
    return new RenderContextImpl._child(this);
  }

  @override
  void enqueue(void Function(RenderContext) callback) {
    if (_parent == null) {
      tasks.addLast(callback);
    } else {
      _parent.enqueue(callback);
    }
  }
}
