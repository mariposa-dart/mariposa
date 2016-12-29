import 'dart:html';
import 'package:mariposa/mariposa.dart';
import '../mdl.dart';
import 'fab.dart';
import 'toolbar.dart';

class AppWidget extends Widget {
  @override
  render() {
    return h('div', {
      'class': 'mdl-layout mdl-js-layout mdl-layout--fixed-header'
    }, [
      new ToolbarWidget(state.title),
      h('main', {
        'class': 'mdl-layout__content'
      }, [
        h('div', {
          'class': 'page-content'
        }, [
          new FabWidget()
            ..onClick.listen((_) {
              window.alert('Fab clicked!');
            })
        ])
      ])
    ]);
  }

  @override
  afterRender(Element $host) {
    componentHandler.upgradeDom();
  }
}
