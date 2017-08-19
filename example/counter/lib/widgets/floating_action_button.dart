import 'package:html_builder/html_builder.dart';
import 'package:html_builder/elements.dart';

Node floatingActionButton(String icon, {style}) {
  return button(
    className: 'mdl-button mdl-js-button mdl-button--fab mdl-button--colored',
    style: style,
    c: [
      i(className: 'material-icons', c: [
        text(icon),
      ]),
    ],
  );
}
