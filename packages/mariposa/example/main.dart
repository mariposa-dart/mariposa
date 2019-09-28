import 'dart:async';
import 'package:html_builder/elements.dart';
import 'package:mariposa/mariposa.dart';
import 'package:mariposa/universal.dart';
import 'package:universal_html/html.dart' hide Node, Text;

main() async {
  var container = DivElement()..text = 'Loading...';
  await renderOnce(TimerApp(), container);

  // Print the results.
  print(container.outerHtml);
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
    return Div(children: [
      Heading.h1(
        child: Text('Mariposa Demo'),
      ),
      Paragraph(children: [
        Text('Elapsed seconds: $seconds'),
      ]),
    ]);
  }
}
