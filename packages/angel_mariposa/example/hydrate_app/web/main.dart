import 'package:hydrate_app/hydrate_app.dart';
import 'package:mariposa/browser.dart';
import 'package:universal_html/html.dart';

main() => runMariposaApp(() => HydrateApp(), querySelector('#app'));
