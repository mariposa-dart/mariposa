import 'dart:async';
import 'dart:html';
import 'package:mariposa/mariposa.dart';
import 'src/browser/browser.dart';
export 'src/browser/browser.dart';

Future<void> runApp(Component app, Element container) async {
  var runner = MariposaBrowserRunner(app, container);
  runner.firstRender();
  return runner.renderer.done;
}

class MariposaBrowserRunner extends MariposaRunner<Node, Element> {
  MariposaBrowserRunner(Component appComponent, Element container)
      : super(appComponent, Renderer<Node, Element>(BrowserIncrementalDom()),
            root: container);
}
