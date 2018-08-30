# mariposa
[![Chat on Gitter](https://img.shields.io/gitter/room/nwjs/nw.js.svg)](https://gitter.im/mariposa_dart/mariposa)
[![Pub](https://img.shields.io/pub/v/mariposa.svg)](https://pub.dartlang.org/packages/mariposa)
[![Build status](https://travis-ci.org/mariposa-dart/mariposa.svg?branch=master)](https://travis-ci.org/mariposa-dart/mariposa)
![License](https://img.shields.io/github/license/mariposa-dart/mariposa.svg)

Stupid-simple, low-level Web application library built with
[Incremental DOM](https://github.com/google/incremental-dom)
and `html_builder`.
Somewhat comparable to React; heavily reminiscent of Flutter.

Mariposa offers *no state management*;
this is by design. Handling state should be handled via
`dart:async`, Redux, or some other mechanism. Calling for a
re-render is not memory-intensive, thanks to Incremental DOM.

Thanks to libraries like `zen` and `html_builder/elements.dart`,
it is possible to cleanly build HTML AST's
with a Dart DSL that looks exactly like an HTML AST.

## Usage

The most simple example:

```dart
import 'dart:html' hide Node;
import 'package:html_builder/elements.dart';
import 'package:html_builder/html_builder.dart';
import 'package:mariposa/dom.dart' as mariposa_dom;

void main() {
  mariposa_dom.render(
    Greeting(message: 'Hello!'),
    querySelector('#app'),
  );
}

class Greeting extends Widget {
  final String message;

  Greeting({@required this.message});

  @override
  Node render() {
    return Text.b(message);
  }
}
```

This is a super-small example of an application without state.
See `web/main.dart` for an example of an application with state.
Complex applications should consider `dart:async`, Redux, Flux,
or some similar state management architecture to create manageable
applications. 

## Widgets
*Note: Not the same as Flutter widgets*.

In real-world applications, oftentimes one will need to interact
with the state of the DOM, or whatever tree is being rendered.

For this, create a `Widget`. Not only can widgets be rendered
like normal nodes, but upon rendering, their `afterRender` method
is called. Right before destruction, `beforeDestroy` is invoked.

Both methods are passed an `AbstractElement`, which prevents a
platform-agnostic way to handle events, perform query selectors,
and other things. Abstract elements always provide a handle to
the `nativeElement`.

This makes it possible to manage the state of a specific node
in the tree, among other things.

```dart
import 'dart:io';
import 'package:html_builder/html_builder.dart';
import 'package:html_builder/elements.dart';
import 'package:mariposa/dom.dart' as mariposa;
```

## Passing down state and context
Passing state down a stateless tree can become ugly very quickly.
However, Mariposa provides a class called `ContextAwareWidget`, which can interact
with a `RenderContext`, a scoped state handled internally by Mariposa.

The `Context` class has provisions for dependency injection
(using [`package:angel_container`](https://github.com/angel-dart/container)
), so you don't need *any* hacks
to have fully independent, context-aware widgets.

The usage of `package:angel_container` also means that you can use the same dependency
injection found in version 2 of the [Angel](https://angel-dart.github.io) framework.

```dart
class MyWidget extends ContextAwareWidget {
  @override
  Node contextAwareRender(RenderContext ctx) {
    // Return something...
  }
}
```

### `StatefulWidget`
Flutter users will immediately recognize this pattern, which is built on top of
`ContextAwareWidget`:

```dart
import 'dart:async';
import 'package:html_builder/elements.dart';
import 'package:html_builder/html_builder.dart';
import 'package:mariposa/mariposa.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _TodoListState();
  }
}

class _TodoListState extends State<TodoList> {
  String message = 'Getting todos...';

  @override
  void initState() {
    super.initState();
    new Future.delayed(const Duration(seconds: 2)).then((_) {
      setState(() {
        message = 'Got todos!';
      });
    });
  }

  @override
  Node render() {
    return div(
      c: [
        h1(),
        i(
          c: [
            text('Hi!'),
          ],
        ),
      ],
    );
  }
}
```

## Server-side Rendering
It's easy; in fact, server-side rendering is Mariposa's
bread-and-butter. DOM support was added long after string rendering:

```dart
import 'dart:io';
import 'package:html_builder/html_builder.dart';
import 'package:html_builder/elements.dart';
import 'package:mariposa/string.dart' as mariposa;

main() async {
  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 3000);
  print('Listening at http://${server.address.address}:${server.port}');

  await for (var request in server) {
    var html = mariposa.render(myApp());
    request.response
      ..headers.contentType = ContentType.HTML
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
```