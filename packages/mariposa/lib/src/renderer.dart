import 'dart:async';
import 'package:html_builder/html_builder.dart';
import 'component.dart';
import 'incremental_dom.dart';
import 'render_context.dart';

class Renderer<NodeType, ElementType extends NodeType> {
  final IncrementalDom<NodeType, ElementType> incrementalDom;
  final Completer _done = Completer();
  StreamSubscription<NodeType> _createdSub, _deletedSub;
  void Function() onUpdate;

  final Map<NodeType, ComponentClass> _unmountedComponents = {};
  final Map<NodeType, ComponentClass> _mountedComponents = {};

  Renderer(this.incrementalDom) {
    _createdSub = incrementalDom.onNodeCreated.listen(onNodeCreated);
    _deletedSub = incrementalDom.onNodeDeleted.listen(onNodeDeleted);
  }

  Future get done => _done.future;

  void onNodeCreated(NodeType node) {
    // If this node corresponds to an unmounted component,
    // then run its afterCreate.
    var cmp = _unmountedComponents.remove(node);
    if (cmp != null) {
      _mountedComponents[node] = cmp;
      cmp
        ..rawNativeElement = node
        ..afterMount();
    }
  }

  void onNodeDeleted(NodeType node) {
    // If this node corresponds to a mounted component,
    // end its lifecycle.
    var cmp = _mountedComponents.remove(node);
    if (cmp != null) {
      cmp.afterUnmount();
    }
  }

  Future<void> close() {
    _done.complete();
    _createdSub?.cancel();
    _deletedSub?.cancel();
    _mountedComponents.forEach(destroyComponent);
    return incrementalDom.close();
  }

  void destroyComponent(NodeType node, ComponentClass component) {
    component.afterUnmount();
  }

  NodeType renderRoot(Component component) {
    var context = RenderContext(component, triggerUpdate: onUpdate);
    return renderNode(component(), context);
  }

  NodeType renderNode(Node vNode, RenderContext context, {String key}) {
    key ??= vNode.attributes[mariposaKey]?.toString();

    // Remove junk attributes.
    var attrs = Map<String, dynamic>.from(vNode.attributes ?? {});
    attrs.removeWhere((k, v) {
      if (v is Iterable) {
        return v.isEmpty;
      } else if (v is Map) {
        return v.isEmpty;
      } else {
        return v == null || v == false;
      }
    });

    // Next, normalize attributes to strings.
    var normAttrs = attrs.map<String, String>((k, v) {
      if (v is Iterable) {
        return MapEntry(k, v.where((x) => x != null).join(' ').trim());
      } else if (v is Map) {
        var buf = v.entries.fold<StringBuffer>(StringBuffer(), (b, entry) {
          if (entry.value == null) return b;
          return b..write('${entry.key}=${entry.value}; ');
        });
        return MapEntry(k, buf.toString().trim());
      } else {
        return MapEntry(k, v.toString());
      }
    });

    // Remove empty attrs.
    normAttrs.removeWhere((k, v) => v.isEmpty);

    if (vNode is ComponentClass) {
      return renderComponent(vNode, context);
    } else if (vNode is TextNode) {
      return incrementalDom.text(vNode.text);
    } else if (vNode is SelfClosingNode) {
      return incrementalDom.elementVoid(vNode.tagName, key, normAttrs);
    } else {
      incrementalDom.elementOpen(vNode.tagName, key, normAttrs);
      for (var child in vNode.children) {
        renderNode(child, context);
      }
      return incrementalDom.elementClose(vNode.tagName);
    }
  }

  NodeType renderComponent(ComponentClass vNode, RenderContext parentContext) {
    var context = parentContext.createChild(vNode);
    vNode.beforeRender(context);
    var node = renderNode(vNode.render(), context, key: vNode.key);
    if (node == null) return null;
    _unmountedComponents[node] = vNode;
    return node;
  }
}
