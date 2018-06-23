import 'dart:io';
import 'package:html_builder/html_builder.dart';
import 'package:html_builder/elements.dart';
import 'package:mariposa/string.dart' as mariposa;

main() async {
  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 3000);
  print('Listening at http://${server.address.address}:${server.port}');

  await for (var request in server) {
    var html = mariposa.render(myApp);
    request.response
      ..headers.contentType = ContentType.html
      ..write(html)
      ..close();
  }
}

Node myApp() {
  return html(c: [
    head(c: [
      meta(
        name: 'viewport',
        content: 'width=device-width, initial-scale=1',
      ),
      title(c: [
        text('Hello, Mariposa!'),
      ]),
    ]),
    body(c: [
      h1(c: [
        text('Hello, Mariposa!'),
      ]),
      i(c: [
        text('Server-side rendering is easy!'),
      ]),
    ]),
  ]);
}
