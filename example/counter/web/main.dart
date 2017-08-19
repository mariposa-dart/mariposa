import 'dart:html' show querySelector;
import 'package:counter/widgets/counter_app.dart';
import 'package:mariposa/browser.dart';

Map<String, int> defaultState() => {'clicks': 0};

main() {
  runApp(
    querySelector('#app'),
    () => new CounterApp(),
    defaultState: defaultState,
  );
}
