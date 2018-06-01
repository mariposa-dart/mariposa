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
  StreamSubscription _addSubscription, _subtractSubscription;

  CounterApp({this.state, this.onClick});

  @override
  void afterRender(AbstractElement element) {
    var add = element.querySelector('#add'),
        subtract = element.querySelector('#subtract');
    _addSubscription = add.listen('click', (_) => onClick.add(1));
    _subtractSubscription = subtract.listen('click', (_) => onClick.add(-1));
  }

  @override
  void beforeDestroy(AbstractElement element) {
    _addSubscription.cancel();
    _subtractSubscription.cancel();
  }

  @override
  Node render() {
    return div(
      c: [
        h1(c: [
          text('${state.clicks} click(s)'),
        ]),
        br(),
        button(
          id: 'add',
          c: [
            text('Add!'),
          ],
        ),
        button(
          id: 'subtract',
          c: [
            text('Subtract!'),
          ],
        ),
        br(),
        ul(
          c: new List.generate(
            state.clicks,
            (i) => li(c: [text('#$i')]),
          ),
        ),
      ],
    );
  }
}
