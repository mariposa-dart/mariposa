import 'component.dart';

class RenderContext {
  final Component component;
  final RenderContext parent;
  final void Function() _triggerUpdate;

  RenderContext(this.component, {this.parent, void Function() triggerUpdate})
      : _triggerUpdate = triggerUpdate;

  RenderContext createChild(Component child) {
    return RenderContext(child, parent: this);
  }

  void triggerUpdate() {
    if (_triggerUpdate != null) {
      _triggerUpdate();
    } else {
      parent?._triggerUpdate();
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
