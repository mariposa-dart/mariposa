import 'dart:io';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_static/angel_static.dart';
import 'package:html_builder/elements.dart';
import 'package:html_builder/html_builder.dart';
import 'package:mariposa/string.dart';
import 'package:todo/todo.dart';

main() async {
  var app = new Angel();
  app.container.singleton(new StringRenderer());

  List<Todo> todos = [
    new Todo('Clean your room'),
    new Todo('Make friends'),
    new Todo('Write a UI framework', completed: true)
  ];

  app.get('/', (ResponseContext res, StringRenderer renderer) {
    var $app =
        runApp(() => new TodoApp(), defaultState: () => {'todos': todos});

    var $dom = html(c: [
      head(c: [
        meta(name: 'viewport', content: 'width=device-width, initial-scale=1'),
        title(),
        link(rel: 'stylesheet', href: 'style.css')
      ]),
      body(c: [$app])
    ]);

    res
      ..contentType = ContentType.HTML
      ..write(renderer.render($dom))
      ..end();
  });

  await app.configure(new VirtualDirectory());

  app.fatalErrorStream.listen((e) {
    stderr..writeln('Fatal error: ${e.error}')..writeln(e.stack);
  });

  var server = await app.startServer(InternetAddress.LOOPBACK_IP_V4, 3000);
  print(
      'Example server listening at http://${server.address.address}:${server.port}');
}
