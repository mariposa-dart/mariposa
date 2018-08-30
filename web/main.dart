import 'dart:async';
import 'dart:html' show querySelector;
import 'package:html_builder/html_builder.dart';
import 'package:html_builder/elements.dart';
import 'package:mariposa/mariposa.dart';
import 'package:mariposa/dom.dart' as mariposa;

void main() {
  // Application state.
  var state = new AppState(clicks: 0);

  // We use a stream to handle user input.
  var onClick = new StreamController<int>();

  // Create a shorthand function to render our application UI.
  var counterApp = () => new CounterApp(state: state, onClick: onClick);

  // Rendering our tree for the first time produces a
  // helper function that we can call whenever we need to refresh the display.
  var rerender = mariposa.render(counterApp, querySelector('#app'));

  // When the click is fired, update the application state,
  // and call for a re-render.
  onClick.stream.listen((count) {
    state.clicks += count;
    if (state.clicks < 0) state.clicks = 0;
    rerender();
  });
}

class AppState {
  int clicks;

  AppState({this.clicks});
}

class CounterApp extends Widget {
  final AppState state;
  final StreamController<int> onClick;

  CounterApp({this.state, this.onClick});

  @override
  Node render() {
    return Div(
      children: [
        Heading.h1(
          child: Text('${state.clicks} click(s)'),
        ),
        BR(),
        Button(
          child: Text('Add!'),
          onClick: (_) {
            onClick.add(1);
          },
        ),
        Button(
          child: Text('Subtract!'),
          onClick: (_) {
            onClick.add(-1);
          },
        ),
        BR(),
        UList(
          children: List.generate(
            state.clicks,
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
