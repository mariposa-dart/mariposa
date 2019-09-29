import 'component.dart';

class RenderContext {
  final String path;
  final Component component;
  final RenderContext parent;
  final Set<String> childPaths = Set();
  final void Function(Iterable<String>) _triggerUpdate;

  RenderContext(this.path, this.component,
      {this.parent, void Function(Iterable<String>) triggerUpdate})
      : _triggerUpdate = triggerUpdate {
    childPaths.add(path);
  }

  RenderContext createChild(String subLocation, Component child) {
    var ctx = RenderContext('$path:$subLocation', child, parent: this);
    var cur = this;
    while (cur != null) {
      cur.childPaths.add(ctx.path);
      cur = cur.parent;
    }
    return ctx;
  }

  void triggerUpdate() {
    if (_triggerUpdate != null) {
      _triggerUpdate(childPaths);
    } else {
      parent?._triggerUpdate(childPaths);
    }
  }

  T findParentOfType<T>() {
    var search = parent;
    while (search != null) {
      if (search.component.runtimeType == T) {
        search = search.parent;
      }
    }
    return null;
  }
}
