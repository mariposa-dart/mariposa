import 'dart:async';
import 'package:html_builder/html_builder.dart';
import 'package:universal_html/html.dart' as html;
import 'component.dart';
import 'incremental_dom.dart';
import 'render_context.dart';

class Renderer<NodeType, ElementType extends NodeType> {
  final IncrementalDom<NodeType, ElementType> incrementalDom;
  final Completer _done = Completer();
  StreamSubscription<NodeType> _createdSub, _deletedSub;
  void Function() onUpdate;

  final Map<String, ComponentClass> _componentCache = {};
  final Map<NodeType, Set<ComponentClass>> _unmountedComponents = {};
  final Map<NodeType, Set<ComponentClass>> _mountedComponents = {};

  Renderer(this.incrementalDom) {
    _createdSub = incrementalDom.onNodeCreated.listen(onNodeCreated);
    _deletedSub = incrementalDom.onNodeDeleted.listen(onNodeDeleted);
  }

  Future get done => _done.future;

  void onNodeCreated(NodeType node) {
    // If this node corresponds to an unmounted component,
    // then run its afterCreate.
    var cmpList = _unmountedComponents.remove(node);
    if (cmpList != null) {
      _mountedComponents[node] = cmpList;
      for (var cmp in cmpList) {
        cmp
          ..rawNativeElement = node as html.Element
          ..afterMount();
      }
    }
  }

  void onNodeDeleted(NodeType node) {
    // If this node corresponds to a mounted component,
    // end its lifecycle.
    var cmpList = _mountedComponents.remove(node);
    if (cmpList != null) {
      for (var cmp in cmpList) {
        cmp.afterUnmount();
      }
    }
  }

  Future<void> close() {
    _done.complete();
    _createdSub?.cancel();
    _deletedSub?.cancel();
    _mountedComponents
        .forEach((n, l) => l.forEach((c) => destroyComponent(n, c)));
    return incrementalDom.close();
  }

  void destroyComponent(NodeType node, ComponentClass component) {
    component.afterUnmount();
  }

  void _handleUpdate(Iterable<String> affectedPaths) {
    // Remove any affected paths from the cache, as they possibly have new content.
    for (var path in affectedPaths) {
      _componentCache.remove(path); //?.afterUnmount();
    }
    if (onUpdate != null) onUpdate();
  }

  NodeType renderRoot(Component component) {
    var context = RenderContext('%r', component, triggerUpdate: _handleUpdate);
    var node = renderNode(
        component is ComponentClass
            ? (component as ComponentClass)
            : component(),
        context);
    return node;
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
          return b..write('${entry.key}: ${entry.value}; ');
        });
        return MapEntry(k, buf.toString().trim());
      } else {
        return MapEntry(k, v.toString());
      }
    });

    // Remove empty attrs.
    normAttrs.removeWhere((k, v) => v.isEmpty);

    if (vNode is ComponentClass) {
      // If we've already rendered a component of this exact type,
      // at this location, return it.
      //
      // This is okay because setState() removes necessary paths from the
      // component cache. Moral of the story: you MUST use setState to update
      // your state.
      ComponentClass cmp = vNode;
      var existing = _componentCache[context.path];
      if (existing != null && existing.runtimeType == vNode.runtimeType) {
        cmp = existing;
      } else {
        _componentCache[context.path] = cmp;
      }
      return renderComponent(cmp, context);
    } else if (vNode is TextNode) {
      return incrementalDom.text(vNode.text);
    } else if (vNode.children.isEmpty) {
      return incrementalDom.elementVoid(vNode.tagName, key, normAttrs);
    } else {
      incrementalDom.elementOpen(vNode.tagName, key, normAttrs);
      for (int i = 0; i < vNode.children.length; i++) {
        var child = vNode.children[i];
        var ctx = context;
        if (child is ComponentClass) ctx = context.createChild('#$i', child);
        renderNode(child, ctx);
      }
      return incrementalDom.elementClose(vNode.tagName);
    }
  }

  NodeType renderComponent(ComponentClass vNode, RenderContext parentContext) {
    var context = vNode.context ??
        parentContext.createChild('@${vNode.runtimeType}', vNode);
    vNode.beforeRender(context);

    var rendered = vNode.render();

    if (rendered is! ComponentClass) {
      // Alert components of new props.
      var newAttrs = vNode.handleAttributesFromRender(rendered.attributes);
      rendered = Node(rendered.tagName, newAttrs, rendered.children);
    }

    var node = renderNode(rendered, context, key: vNode.key);
    if (node == null) return null;
    if (!_mountedComponents.containsKey(node)) {
      _unmountedComponents.putIfAbsent(node, () => Set())..add(vNode);
    }
    return node;
  }
}
