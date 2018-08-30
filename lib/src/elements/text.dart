import 'package:html_builder/html_builder.dart';
import 'html_element.dart';

class Text extends HtmlWidget {
  Text._(String tagName, String text,
      {String id, className, Style style, Map<String, dynamic> props})
      : super(tagName, id, className, style, props, {}, []);

  factory Text(String text,
      {String id, className, Style style, Map<String, dynamic> props}) {
    return new Text._('span', text,
        id: id, className: className, style: style, props: props);
  }

  factory Text.bold(String text,
      {String id, className, Style style, Map<String, dynamic> props}) {
    return new Text._('b', text,
        id: id, className: className, style: style, props: props);
  }
  factory Text.italicized(String text,
      {String id, className, Style style, Map<String, dynamic> props}) {
    return new Text._('i', text,
        id: id, className: className, style: style, props: props);
  }

  factory Text.strong(String text,
      {String id, className, Style style, Map<String, dynamic> props}) {
    return new Text._('strong', text,
        id: id, className: className, style: style, props: props);
  }
  factory Text.underlined(String text,
      {String id, className, Style style, Map<String, dynamic> props}) {
    return new Text._('u', text,
        id: id, className: className, style: style, props: props);
  }
}