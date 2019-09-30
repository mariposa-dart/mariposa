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

    test('node with children', () {
      idom.elementOpen('foo', null, {'a': 'b'});
      idom.elementOpen('bar', null, {'c': 'd'});
      idom.elementOpen('baz', null, {'e': 'f'});
      var baz = idom.elementClose('baz');
      var quux = idom.elementVoid('quux', null, {'g': 'h'});
      var bar = idom.elementClose('bar');
      var foo = idom.elementClose('foo');
      expect(foo.children, hasLength(1));
      expect(foo.children[0], bar);
      expect(bar.children, hasLength(2));
      expect(bar.children, [baz, quux]);
      print(foo.outerHtml);
    });

    test('inner text', () {
      idom.elementOpen('div', null, {});
      idom..text('hel')..text('lo ')..text('world');
      var div = idom.elementClose('div');
      expect(div.text, 'hello world');
    });

    test('elementClose expects consistent name', () {
      expect(() {
        idom
          ..elementOpen('a', null, {})
          ..elementClose('b');
      }, throwsStateError);
    });

    test('text cannot be called without parent', () {
      expect(() => idom.text('orphan'), throwsStateError);
    });
  });
}
