import 'package:mariposa/mariposa.dart';

class ToolbarWidget extends Widget {
  final String title, icon;

  ToolbarWidget(this.title, {this.icon: 'menu'});

  @override
  render() {
    return h('div', {
      'class': 'mdl-layout__header'
    }, [
      h('div', {
        'class': 'mdl-layout__drawer-button'
      }, [
        h('i', {'class': 'material-icons'}, [text('menu')])
      ]),
      h('div', {
        'class': 'mdl-layout__header-row'
      }, [
        h('span', {'class': 'mdl-layout-title'}, [text(title)])
      ])
    ]);
  }
}
