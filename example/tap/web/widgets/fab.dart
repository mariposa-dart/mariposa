import 'dart:async';
import 'dart:html';
import 'package:mariposa/mariposa.dart';

class FloatingActionButton extends Widget {
  final StreamController<MouseEvent> _onClick =
      new StreamController<MouseEvent>.broadcast();
  Stream<MouseEvent> get onClick => _onClick.stream;

  @override
  render() {
    return h('button', {
      'class': 'mdl-button mdl-js-button mdl-button--fab mdl-button--colored'
    }, [
      h('i', {'class': 'material-icons'}, [text('add')])
    ]);
  }

  @override
  afterRender($host) {
    $host
      ..style.position = 'fixed'
      ..style.bottom = '1em'
      ..style.right = '1em'
      ..onClick.listen(_onClick.add);
  }
}
