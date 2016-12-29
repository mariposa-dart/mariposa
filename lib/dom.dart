import 'dart:async';
import 'dart:html';
import 'mariposa.dart' as m;

final _DomRenderer MARIPOSA = new _DomRenderer();
const String MARIPOSA_ID = 'mariposa-id';

void TIME_TRAVEL(m.StateUpdateEvent e) {
  window.console
    ..log('STATE UPDATE: ${e.key} = ${e.value}')
    ..log('Previous state:')
    ..log(e.oldState);
}

class _DomRenderer {
  final StreamController<m.StateUpdateEvent> _onUpdate =
      new StreamController<m.StateUpdateEvent>.broadcast();
  m.Node _root;
  Element _rootElement;
  m.State _state;
  final Map<m.Node, int> _memo = {};

  Stream<m.StateUpdateEvent> get onUpdate => _onUpdate.stream;

  void render(m.Node rootNode, Element target,
      {Map<String, dynamic> initialState}) {
    _state = new m.State.fromMap(initialState ?? {});

    var converted = _convertToNode(_root = rootNode);
    _renderElem(rootNode is m.Widget ? rootNode : null, converted,
        _rootElement = document.createElement(converted.tagName));
    target.children
      ..clear()
      ..add(_rootElement);

    if (rootNode is m.Widget) {
      _listenToState(rootNode.state);
    }
  }

  void _listenToState(m.State state) {
    state.onUpdate.listen((e) {
      _onUpdate.add(e);
      var newState = new m.State.fromMap(e.newState);

      // Todo: Update
      _state = newState;
    });
  }

  void _renderElem(m.Widget source, m.Node node, Element target) {
    var converted = _convertToNode(node);

    converted.attributes.forEach((k, v) {
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
          v.forEach(target.style.setProperty);
        }
      }
    });

    for (var childNode in converted.children) {
      if (childNode is m.TextNode) {
        target.text = childNode.text;
      }
    }

    for (var childNode in converted.children) {
      if (childNode is m.TextNode) continue;

      var converted = _convertToNode(childNode);
      var childElement = document.createElement(converted.tagName);
      target.children.add(childElement);
      _renderElem(
          childNode is m.Widget ? childNode : null, converted, childElement);
    }

    _memoize(node, target);

    if (source != null) {
      source.afterRender(target);
    }
  }

  m.Node _convertToNode(m.Node node) {
    if (node is m.Widget) {
      node.state = _state;
      return node.render();
    } else
      return node;
  }

  void _memoize(m.Node node, Element target) {
    int id = _memo.containsKey(node) ? _memo[node] : _memo[node] = _memo.length;
    target.dataset[MARIPOSA_ID] = id.toString();
  }
}
