import 'package:mariposa/mariposa.dart';
import 'package:html_builder/elements.dart';
import 'package:html_builder/html_builder.dart';
import 'app_layout.dart';
import 'floating_action_button.dart';

class CounterApp extends Widget {
  @override
  Node render(State state) {
    return appLayout(
      'Counter',
      c: [
        div(
          style: {'padding': '5em', 'text-align': 'center'},
          c: [
            text('Clicked ${state['clicks']} time(s)!'),
          ],
        ),
        floatingActionButton(
          'add',
          style: {
            'position': 'fixed',
            'bottom': '1em',
            'right': '1em',
          },
        )
      ],
    );
  }

  @override
  void afterRender(AbstractElement $element, State state) {
    // Grab a reference to the FAB button.
    // This will work server-side as well. Hooray!
    var $fab = $element.querySelector('button');

    $fab.listen('click', (_) {
      // Let Mariposa take care of handling state changes.
      // You just have to dispatch them.
      state['clicks']++;
    });
  }
}
