import 'dart:async';
import 'package:mariposa/mariposa.dart';
import 'renderer.dart';

abstract class MariposaRunner<NodeType, ElementType extends NodeType> {
  final Renderer<NodeType, ElementType> renderer;
  final Component appComponent;
  bool allowUpdate;
  NodeType _root;

  MariposaRunner(this.appComponent, this.renderer,
      {NodeType root, bool allowUpdate = true}) {
    _root = root;
    if (allowUpdate) {
      renderer.onUpdate = _onUpdate;
    }
  }

  Future<void> close() => renderer.close();

  NodeType render() => renderer.renderRoot(appComponent);

  void clearRootChildren(ElementType element);

  void firstRender() {
    if (_root == null) {
      _root = render();
    } else {
      if (_root is ElementType) {
        clearRootChildren(_root as ElementType);
      }
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
