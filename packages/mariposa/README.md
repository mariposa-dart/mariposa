# mariposa
[![Chat on Gitter](https://img.shields.io/gitter/room/nwjs/nw.js.svg)](https://gitter.im/mariposa_dart/mariposa)
[![Pub](https://img.shields.io/pub/v/mariposa.svg)](https://pub.dartlang.org/packages/mariposa)
[![Build status](https://travis-ci.org/mariposa-dart/mariposa.svg?branch=master)](https://travis-ci.org/mariposa-dart/mariposa)
![License](https://img.shields.io/github/license/mariposa-dart/mariposa.svg)

React-esque Web application framework for Dart. Supports SSR and more.
Comparable to React or Flutter.

```dart
class DateTimeView extends ComponentClass {
  render() {
    return Div(children: [Text('$date')]);
  }
}

runMariposaApp(
  () => DateTimeView(DateTime.now()),
  querySelector('#app'),
);
```
