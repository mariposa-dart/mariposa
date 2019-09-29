import 'package:angel_container/mirrors.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_framework/http.dart';
import 'package:angel_mariposa/angel_mariposa.dart';
import 'package:mariposa/mariposa.dart';
import 'package:logging/logging.dart';
import 'package:pretty_logging/pretty_logging.dart';

main() async {
  // Logging boilerplate
  hierarchicalLoggingEnabled = true;

  // Create a server + HTTP listener.
  var logger = Logger('mariposa_ssr')..onRecord.listen(prettyLog);
  var app = Angel(logger: logger, reflector: MirrorsReflector());
  var http = AngelHttp(app);

  // Configure Angel to transform Mariposa components into HTML responses.
  app.fallback(injectMariposaSerializer());

  // Actual routes...
  app.get('/', (req, res) {
    return Div(children: [
      Heading.h1(child: Text('Welcome!')),
      Paragraph(
        children: [
          Text('Your IP address: ${req.ip}'),
        ],
      ),
    ]);
  });

  // Actual routes...
  app.get('/image', ioc((@Query('url') String url) {
    return Image(
      src: url,
      style: Style(
        border: '4px solid red',
        borderRadius: '4px',
        maxHeight: '4em',
      ),
    );
  }));

  // 404 page.
  app.fallback((req, res) {
    res.statusCode = 404;
    return Heading.h1(child: Text('404. No file exists at ${req.uri}. :('));
  });

  // Launch.
  await http.startServer('127.0.0.1', 3000);
  print('SSR demo listening at ${http.uri}');
}
