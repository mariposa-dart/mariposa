import 'package:mariposa/mariposa.dart';
import 'package:mariposa/universal.dart';
import 'package:test/test.dart';

void main() {
  UniversalIncrementalDom idom;

  setUp(() async {
    idom = UniversalIncrementalDom();
  });

  tearDown(() => idom?.close());

  group('build', () {
    test('node without attributes', () {
      var el = idom.elementVoid('foo', null, {});
      expect(el.localName, 'FOO');
      expect(el.attributes, isEmpty);
    });

    test('node with attributes', () {
      var el = idom.elementVoid('bar', null, {'baz': 'quux'});
      expect(el.localName, 'BAR');
      expect(el.attributes, {'baz': 'quux'});
    });

    test('sets key', () {
      var el = idom.elementVoid('bar', 'hello', {'baz': 'quux'});
      expect(el.localName, 'BAR');
      expect(el.attributes, {'baz': 'quux', mariposaKey: 'hello'});
    });
  });
}
