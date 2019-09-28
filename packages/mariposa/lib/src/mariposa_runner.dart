import 'dart:async';
import 'package:mariposa/mariposa.dart';
import 'renderer.dart';

class MariposaRunner<NodeType, ElementType extends NodeType> {
  final Renderer<NodeType, ElementType> renderer;
  final Component appComponent;
  NodeType _root;

  MariposaRunner(this.appComponent, this.renderer, {NodeType root}) {
    _root = root;
    renderer.onUpdate = _onUpdate;
  }

  Future<void> close() => renderer.close();

  NodeType render() => renderer.renderRoot(appComponent);

  void firstRender() {
    if (_root != null) {
      _root = render();
    } else {
      _onUpdate();
    }
  }

  void _onUpdate() {
    if (_root is ElementType) {
      renderer.incrementalDom.patch(_root as ElementType, render);
    } else {
      _root = render();
    }
  }
}