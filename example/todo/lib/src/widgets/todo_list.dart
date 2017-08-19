import 'package:html_builder/elements.dart';
import 'package:html_builder/html_builder.dart';
import '../models/todo.dart';
import 'package:mariposa/mariposa.dart';
import 'todo_item.dart';

// TODO: Stateful...?
bool tab = false;

const tabStyle = const {'cursor': 'pointer'};

class TodoList extends Widget {
  final List<Todo> todos;

  TodoList(this.todos);

  @override
  void afterRender(AbstractElement $element, State state) {
    var tabs = $element.querySelectorAll('.tabular.menu .item');

    for (int i = 0; i < tabs.length; i++) {
      bool type = i > 0;
      tabs.elementAt(i).listen('click', (_) {
        state.notify(() {
          tab = type;
        });
      });
    }
  }

  render(_) {
    /*
  <div class="ui top attached tabular menu">
    <div class="item">Tab</div>
  </div>
   */

    String itemType(bool type) => tab == type ? 'active item' : 'item';

    var tabMenu = div(className: 'ui top attached tabular menu', c: [
      div(
        className: itemType(false),
        style: tabStyle,
        c: [text('Incomplete')],
      ),
      div(
        className: itemType(true),
        style: tabStyle,
        c: [text('Complete')],
      ),
    ]);

    Node content;
    var selected = todos.where((t) => t.completed == tab);

    if (selected.isEmpty) {
      content = div(className: 'ui message', c: [
        text('Nothing to see here.'),
      ]);
    } else {
      content = div(c: [
        div(className: 'ui message', c: [
          text('Click a todo to toggle complete/incomplete.'),
        ]),
        br(),
        br(),
        div(
          className: 'ui middle aligned divided list',
          c: selected.map((todo) {
            /*
            <div class="item">
              <div class="right floated content">
                <div class="ui button">Add</div>
              </div>
              <img class="ui avatar image" src="/images/avatar2/small/lena.png">
              <div class="content">
                Lena
              </div>
            </div>
             */
            return div(
              className: 'item',
              c: [
                div(className: 'right floated content', c: [
                  button(className: 'ui negative button', c: [
                    i(className: 'delete icon'),
                    text('Delete'),
                  ]),
                ]),
                div(
                  className: 'content',
                  c: [text(todo.text)],
                ),
              ],
            );
          }),
        ),
      ]);
    }

    return div(
      c: [tabMenu, content],
    );
  }
}
