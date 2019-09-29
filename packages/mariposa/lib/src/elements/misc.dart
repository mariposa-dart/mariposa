import 'package:html_builder/elements.dart';
import 'package:mariposa/mariposa.dart';
import 'package:merge_map/merge_map.dart';
import 'package:meta/meta.dart';
import 'package:universal_html/html.dart' show Event, ImageElement;
import 'html_element.dart';

class Image extends Html5Component<ImageElement> {
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
      void Function(ImageElement) onMount,
      Ref<ImageElement> ref,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners})
      : super.bare(
            key,
            'img',
            id,
            className,
            style,
            onMount,
            ref,
            mergeMap([
              {
                'alt': alt,
                'height': height,
                'src': src,
                'title': title,
                'width': width
              },
              props
            ]),
            eventListeners,
            []);

  beforeRender(RenderContext context) {
    print('Initialize IMAGE $hashCode');
    super.beforeRender(context);
  }
}

class Builder extends ComponentClass {
  final Node Function() builder;

  Builder(this.builder);

  @override
  Node render() => builder();
}

class Conditional extends ComponentClass {
  final bool condition;
  final Node child;

  Conditional({this.condition = true, @required this.child});

  @override
  Node render() {
    if (!condition) {
      return span(style: 'display: none');
    }
    return child;
  }
}
