import 'dart:async';
import 'package:mariposa/mariposa.dart';
import 'package:universal_html/html.dart' as html;
import 'universal_incremental_dom.dart';

Future<void> renderOnce(Component app, html.Element container) async {
  var runner = MariposaUniversalRunner(app, container, allowUpdate: false);
  runner.firstRender();
  return runner.close();
}

Future<void> runMariposaApp(Component app, html.Element container) async {
  var runner = MariposaUniversalRunner(app, container);
  runner.firstRender();
  return runner.renderer.done;
}

class MariposaUniversalRunner extends MariposaRunner<html.Node, html.Element> {
  MariposaUniversalRunner(Component appComponent, html.Element container,
      {bool allowUpdate = true})
      : super(appComponent,
            Renderer<html.Node, html.Element>(UniversalIncrementalDom()),
            root: container, allowUpdate: allowUpdate);
}
