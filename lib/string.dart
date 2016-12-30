library mariposa.string;

import 'package:html/dom.dart';
import 'package:mariposa/mariposa.dart' as m;

const Mariposa MARIPOSA = const Mariposa();

class Mariposa {
  const Mariposa();

  String render(m.Node rootNode, Element target,
      {Map<String, dynamic> initialState: const {}}) {
    var state = new m.State.fromMap(initialState ?? {});
    Map<int, int> memo = {};

    _renderInto(state, memo, _convertToWidget(rootNode), rootNode, target);

    return target.outerHtml;
  }

  void _renderInto(m.State state, Map<int, int> memo, m.Widget source,
      m.Node node, Element target,
      {int existingId}) {
    var converted = _convertToNode(state, node);

    _copyAttributes(converted, target);

    int id = existingId ?? _memoize(memo, source ?? node, target);

    for (var childNode in converted.children) {
      if (childNode is m.TextNode) {
        target.text = childNode.text;
        memo[childNode.hashCode] = id;
      }
    }

    for (var childNode in converted.children) {
      if (childNode is m.TextNode) continue;

      var converted = _convertToNode(state, childNode);
      var childElement = new Element.tag(converted.tagName);
      target.children.add(childElement);
      _renderInto(
          state, memo, _convertToWidget(childNode), converted, childElement,
          existingId: memo[childNode.hashCode]);
    }
  }

  int _memoize(Map<int, int> memo, m.Node node, Element target) {
    int id = memo.containsKey(node.hashCode)
        ? memo[node.hashCode]
        : memo[node.hashCode] = memo.length;
    target.attributes['data-mariposa-id'] = id.toString();
    return id;
  }

  void _copyAttributes(m.Node node, Element target) {
    node.attributes.forEach((k, v) {
      if (k != 'class' && k != 'style') {
        target.attributes[k] = v.toString();
      } else if (k == 'class') {
        if (v is String) {
          target.attributes['class'] = v;
        } else if (v is List) {
          target.classes.addAll(v.map((x) => x.toString()));
        }
      } else {
        if (v is String) {
          target.attributes['style'] = v;
        } else if (v is Map<String, dynamic>) {
          List<String> styles = [];

          v.forEach((k, v) {
            styles.add('$k: v');
          });

          target.attributes['style'] = styles.join(';');
        }
      }
    });
  }

  m.Node _convertToNode(m.State state, m.Node node) {
    if (node is m.Widget) {
      node.state = state;
      return node.render();
    } else
      return node;
  }

  m.Widget _convertToWidget(m.Node node) {
    return node is m.Widget ? node : null;
  }
}
