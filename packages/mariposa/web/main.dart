import 'dart:async';
import 'package:html_builder/elements.dart';
import 'package:mariposa/browser.dart';
import 'package:mariposa/mariposa.dart';
import 'package:universal_html/html.dart' hide Node;

main() {
  return runMariposaApp(TimerApp(), querySelector('#app'));
}

class TimerApp extends ComponentClass {
  int seconds = 0;
  Timer timer;

  @override
  void afterMount() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() => seconds++);
    });
  }

  @override
  void afterUnmount() {
    timer?.cancel();
  }

  @override
  Node render() {
    return div(c: [
      h1(c: [text('Mariposa Demo')]),
      p(c: [
        text('Elapsed seconds: $seconds'),
      ]),
    ]);
  }
}
