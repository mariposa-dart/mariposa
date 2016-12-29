import 'package:mariposa/mariposa.dart';
import 'fab.dart';
import 'toolbar.dart';
import '../mdl.dart';

class App extends Widget {
  @override
  void afterRender(_) => componentHandler.upgradeDom();

  @override
  Node render() {
    return h('div', {
      'class': 'mdl-layout mdl-js-layout mdl-layout--fixed-header'
    }, [
      new Toolbar('Mariposa Demo'),
      h('main', {
        'class': 'mdl-layout__content'
      }, [
        h('div', {
          'class': 'page-content'
        }, [
          new FloatingActionButton()
            ..onClick.listen((_) {
              state.set('clicks', (state['clicks'] ?? 0) + 1);
            }),
          text('Button tapped ${state["clicks"] ?? 0} times.')
        ])
      ])
    ]);
  }
}
