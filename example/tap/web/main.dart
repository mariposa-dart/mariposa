import 'dart:html';
import 'package:mariposa/dom.dart';
import 'widgets/widgets.dart';

main() {
  MARIPOSA
    ..onUpdate.listen(TIME_TRAVEL)
    ..render(new App(), document.getElementById('app'));
}
