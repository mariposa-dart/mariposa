import 'package:mariposa/mariposa.dart';
import 'package:meta/meta.dart';
import 'package:universal_html/html.dart' show Event;
import 'html_element.dart';

class Image extends BaseHtmlComponent {
  Image(
      {String key,
      String id,
      @required String src,
      String alt,
      String title,
      int height,
      int width,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners})
      : super(
            key,
            'img',
            id,
            className,
            style,
            Map.from(props)
              ..addAll({
                'alt': alt,
                'height': height,
                'src': src,
                'title': title,
                'width': width
              }),
            eventListeners,
            []);
}

class Builder extends ComponentClass {
  final Node Function() builder;

  Builder(this.builder);

  @override
  Node render() => builder();
}
