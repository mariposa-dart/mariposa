import 'component.dart';

class RenderContext {
  final Component component;
  final RenderContext parent;

  RenderContext(this.component, {this.parent});

  RenderContext createChild(Component child) {
    return RenderContext(child, parent: this);
  }
}
