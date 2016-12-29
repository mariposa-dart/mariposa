/// Shorthand function to generate a new [Node].
Node h(String tagName,
        [Map<String, dynamic> attributes = const {},
        List<Node> children = const []]) =>
    new Node(tagName, attributes, children);

Node text(String text) => new TextNode(text);

class Node {
  final String tagName;
  final Map<String, dynamic> attributes = {};
  final List<Node> children = [];

  Node(this.tagName,
      [Map<String, dynamic> attributes = const {},
      List<Node> children = const []]) {
    this..attributes.addAll(attributes ?? {})..children.addAll(children ?? []);
  }
}

class TextNode extends Node {
  final String text;

  TextNode(this.text):super(':text');
}