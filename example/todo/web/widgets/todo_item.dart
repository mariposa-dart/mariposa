import 'package:mariposa/mariposa.dart';
import '../todo.dart';

class TodoItemWidget extends Widget {
  final Todo todo;

  TodoItemWidget(this.todo);

  @override
  render() {
    return h('li', {
      'class': 'mdl-list__item'
    }, [
      h('span', {
        'class': [
          'mdl-list__item-primary-content',
          todo.completed ? 'complete' : 'incomplete'
        ]
      }, [
        text(todo.title)
      ]),
      h('span', {
        'class': 'mdl-list__item-secondary-action'
      }, [
        h('label', {
          'class': 'mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect'
        }, [
          h(
              'input',
              {'type': 'checkbox', 'class': 'mdl-checkbox__input'}
                ..addAll(todo.completed ? {'checked': 'true'} : {}))
        ])
      ])
    ]);
  }
}
