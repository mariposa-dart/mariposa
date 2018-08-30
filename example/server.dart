import 'dart:io';
import 'package:html_builder/html_builder.dart';
import 'package:html_builder/elements.dart';
import 'package:mariposa/mariposa.dart';
import 'package:mariposa/string.dart' as mariposa;

main() async {
  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 3000);
  print('Listening at http://${server.address.address}:${server.port}');

  await for (var request in server) {
    var html = mariposa.render(MyApp(),
        createRenderer: () =>
            new StringRenderer(whitespace: '', pretty: false));
    request.response
      ..headers.set('content-type', 'text/html')
      ..write(html)
      ..close();
  }
}

class MyApp extends Widget {
  @override
  Node render() {
    return Html(
      lang: 'en',
      children: [
        Head(children: [
          Meta(
            name: 'viewport',
            content: 'width=device-width, initial-scale=1',
          ),
          Title(
            child: TextNode('Hello, Mariposa!'),
          ),
        ]),
        Body(
          children: [
            Heading.h1(
              child: TextNode('Hello, Mariposa!'),
            ),
            Text.italicized('Server-side rendering is easy!'),
          ],
        ),
      ],
    );
  }
}
