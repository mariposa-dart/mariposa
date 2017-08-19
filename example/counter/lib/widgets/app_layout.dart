import 'package:html_builder/elements.dart';
import 'package:html_builder/html_builder.dart';

Node appLayout(String title, {Iterable<Node> c = const []}) {
  return div(
    className: 'mdl-layout mdl-js-layout mdl-layout--fixed-header',
    c: [
      header(
        className: 'mdl-layout__header',
        c: [
          div(className: 'mdl-layout__drawer-button', c: [
            i(className: 'material-icons', c: [
              text('menu'),
            ]),
          ]),
          div(className: 'mdl-layout__header-row', c: [
            span(
              className: 'mdl-layout-title',
              c: [
                text(title),
              ],
            ),
          ]),
        ],
      ),
      main(className: 'mdl-layout__content', c: [
        div(
          className: 'page-content',
          c: c ?? [],
        ),
      ]),
    ],
  );
}
