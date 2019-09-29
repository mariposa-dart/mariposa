import 'package:mariposa/mariposa.dart';
import 'package:mariposa/universal.dart';
import 'package:universal_html/html.dart' hide Node, Text;

main() async {
  var container = DivElement()
    ..id = 'container'
    ..text = 'Loading...';
  await renderOnce(HelloApp(), container);

  // Print the results.
  print(container.outerHtml);
}

class HelloApp extends ComponentClass {
  @override
  Node render() {
    return Div(children: [
      Heading.h1(
        child: Text('Hello, Universal Mariposa!'),
      ),
    ]);
  }
}
