import 'dart:html' show querySelector;
import 'package:html_builder/html_builder.dart';
import 'package:html_builder/elements.dart';
import 'package:mariposa/mariposa.dart';
import 'package:mariposa/dom.dart' as mariposa;

void main() {
  // Create a shorthand function to render our application UI.
  var counterApp = () => CounterApp();

  // Rendering our tree for the first time produces a
  // helper function that we can call whenever we need to refresh the display.
  mariposa.render(counterApp, querySelector('#app'));
}

class CounterApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CounterAppState();
  }
}

class _CounterAppState extends State<CounterApp> {
  int clicks = 0;

  @override
  Node render() {
    return Div(
      children: [
        Heading.h1(
          child: Text('$clicks click(s)'),
        ),
        BR(),
        Button(
          child: Text('Add!'),
          onClick: (_) {
            setState(() {
              clicks++;
            });
          },
        ),
        Button(
          child: Text('Subtract!'),
          onClick: (_) {
            setState(() {
              clicks--;
            });
          },
        ),
        BR(),
        UList(
          children: List.generate(
            clicks,
            (i) {
              return LI(
                children: [
                  Text.i('#$i'),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
