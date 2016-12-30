import 'dart:html' show Element;
import 'package:mariposa/mariposa.dart';

abstract class DomWidget extends Widget {
  void afterDomRender(Element $host);

  @override
  void afterRender($host) {
    super.afterRender($host);
    if ($host is Element) afterDomRender($host);
  }
}

class Center extends DomWidget {
  final Node child;

  Center({this.child});

  @override
  void afterDomRender(Element $host) {}

  @override
  Node render() {
    return h('div', {
      'style': {'margin': '0 auto', 'text-align': 'center', 'width': '100%'}
    }, [
      child
    ]);
  }
}
