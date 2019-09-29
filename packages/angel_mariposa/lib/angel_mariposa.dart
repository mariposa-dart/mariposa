import 'dart:async';
import 'package:angel_framework/angel_framework.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mariposa/mariposa.dart';
import 'package:mariposa/universal.dart';
import 'package:universal_html/html.dart';

RequestHandler injectMariposaSerializer(
    {Element Function() createContainer, String Function(String) template}) {
  createContainer ??= () => DivElement()..id = 'app';
  return (RequestContext req, ResponseContext res) {
    var oldSerializer = res.serializer;
    res.serializer = (x) async {
      if (x is ComponentClass) {
        var body = createContainer();
        await renderOnce(x, body);
        res.contentType = MediaType('text', 'html');
        if (template == null) return body.innerHtml;
        return template(body.innerHtml);
      } else {
        return await oldSerializer(x);
      }
    };
    return Future.value(true);
  };
}
