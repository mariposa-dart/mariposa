import 'dart:async';
import 'dart:html' as html;
import 'package:mariposa/mariposa.dart';
import 'src/browser/browser.dart';
export 'src/browser/browser.dart';

Future<void> runApp(Component app, html.Element container) async {
  var runner = MariposaBrowserRunner(app, container);
  runner.firstRender();
  return runner.renderer.done;
}

class MariposaBrowserRunner extends MariposaRunner<html.Node, html.Element> {
  MariposaBrowserRunner(Component appComponent, html.Element container)
      : super(appComponent,
            Renderer<html.Node, html.Element>(BrowserIncrementalDom()),
            root: container);
}
