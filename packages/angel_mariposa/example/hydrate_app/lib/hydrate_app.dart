import 'package:mariposa/mariposa.dart';
import 'package:universal_html/html.dart' hide Node, Text;

/// Simple app with a click me button.
class HydrateApp extends ComponentClass {
  String status = 'Not yet clicked';
  int clicks = 0;

  @override
  void afterMount() {
    window.console.info('Mounted! Your hydrated app is ready-to-go! :)');
  }

  @override
  Node render() {
    return Div(children: [
      Paragraph(children: [Text(status)]),
      Button(
        child: Text('Click me!'),
        onClick: (_) {
          setState(() => status = 'Clicked ${++clicks} time(s)!');
        },
      ),
    ]);
  }
}
