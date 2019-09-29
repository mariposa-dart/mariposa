import 'package:angel_container/mirrors.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_framework/http.dart';
import 'package:angel_mariposa/angel_mariposa.dart';
import 'package:angel_proxy/angel_proxy.dart';
import 'package:angel_static/angel_static.dart';
import 'package:file/local.dart';
import 'package:http/io_client.dart';
import 'package:hydrate_app/hydrate_app.dart';
import 'package:mariposa/mariposa.dart';
import 'package:logging/logging.dart';
import 'package:pretty_logging/pretty_logging.dart';

main() async {
  // Logging boilerplate
  hierarchicalLoggingEnabled = true;

  // Create a server + HTTP listener.
  var logger = Logger('hydrate_app')..onRecord.listen(prettyLog);
  var app = Angel(logger: logger, reflector: MirrorsReflector());
  var http = AngelHttp(app);
  var fs = LocalFileSystem();

  // Configure Angel to transform Mariposa components into HTML responses.
  app.fallback(injectMariposaSerializer(template: (dom) {
    return '''
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>
</head>
<body>
  <div id="app">$dom</div>
  <script src="https://ajax.googleapis.com/ajax/libs/incrementaldom/0.5.1/incremental-dom-min.js"></script>
  <script src="main.dart.js"></script>
</body>
</html>
''';
  }));

  // Serve our app at the index.
  app.get('/', (req, res) => HydrateApp());

  // In development, we need to proxy over `build_runner serve`.
  //   * Make sure you run `pub run build_runner serve` in another shell.
  // In production, though, serve files from `build/web`'.
  //   * Make sure you've run `pub run build_runner build --release -o build` first.
  //   * You'll then run `ANGEL_ENV=production dart bin/main.dart`.
  if (!app.environment.isProduction) {
    var pbrServeUrl = Uri.parse('http://localhost:8080');
    var proxy = Proxy(IOClient(), pbrServeUrl, recoverFromDead: false);
    app
      ..fallback(proxy.handleRequest)
      ..shutdownHooks.add((_) => proxy.close());
  } else {
    var vDir =
        CachingVirtualDirectory(app, fs, source: fs.directory('./build/web'));
    app.fallback(vDir.handleRequest);
  }

  // 404 page.
  app.fallback((req, res) {
    res.statusCode = 404;
    return Heading.h1(child: Text('404. No file exists at ${req.uri}. :('));
  });

  // Launch.
  await http.startServer('127.0.0.1', 3000);
  print('hydrate_app demo listening at ${http.uri}');
}
