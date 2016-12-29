import 'package:mariposa/mariposa.dart';
import 'todo_item.dart';

class TodoListWidget extends Widget {
  @override
  render() {
    return h('ul', {'class': 'mdl-list'},
        (state.todos ?? []).map((todo) => new TodoItemWidget(todo)));
  }
}
