import 'package:mariposa/mariposa.dart';
import 'package:mariposa/immutable_state.dart';
import 'package:universal_html/html.dart' show WebSocket;

class StatefulApp extends ComponentClass {
  @override
  Node render() {
    return ImmutableManager(
      initialValue: null,
      child: WebSocketStatus(),
    );
  }
}

class WebSocketStatus extends ComponentClass {
  @override
  Node render() {
    return ImmutableView<AppState>(
      builder: (imm) {
        var ws = imm.current.webSocket;
        return Paragraph(children: [
          Text('WebSocket: ${ws?.readyState ?? '<none>'}'),

          // Whenever the WebSocket is opened, we'll place a new value
          // in the state. Mariposa will be automatically updated (it
          // really just calls setState under-the-hood).
          WebSocketConnector((ws) {
            imm.change((state) => state.copyWith(webSocket: ws));
          }),
        ]);
      },
    );
  }
}

class WebSocketConnector extends ComponentClass {
  final void Function(WebSocket) onConnect;

  WebSocketConnector(this.onConnect);

  @override
  void afterMount() {
    var ws = WebSocket('ws://example.com/websocket/path');
    ws.onOpen.first.then((_) => onConnect(ws));
  }

  @override
  Node render() =>
      Text('This widget is a contrived example that does background work.');
}

class AppState {
  final WebSocket webSocket;
  final String authToken;

  AppState({this.webSocket, this.authToken});

  AppState copyWith({WebSocket webSocket, String authToken}) {
    return AppState(
        webSocket: webSocket ?? this.webSocket,
        authToken: authToken ?? this.authToken);
  }
}
