import 'package:mariposa/mariposa.dart';
import 'package:mariposa/universal.dart';
import 'package:test/test.dart';
import 'package:universal_html/html.dart';

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

  group('patch', () {
    test('cannot effectively change root', () {
      var el = idom.elementVoid('foo', null, {});
      idom.patch(el, () => idom.elementVoid('bar', null, {'a': 'b'}));
      expect(el.localName, 'FOO');
      expect(el.attributes, isEmpty);
    });

    group('empty root', () {
      Element root;

      setUp(() {
        root = idom.elementVoid('div', null, {'id': 'app'});
      });

      test('add children', () {
        idom.patch(root, () {
          idom
            ..elementVoid('x-app', null, {'foo': 'bar'})
            ..elementVoid('x-other-app', null, {'food': 'bard'});
        });
        print(root.outerHtml);
        expect(root.outerHtml,
            '<div id="app"><x-app foo="bar"></x-app><x-other-app food="bard"></x-other-app></div>');
      });

      test('add text and children', () {
        idom.patch(root, () {
          idom
            ..text('A')
            ..elementVoid('x-app', null, {'foo': 'bar'})
            ..text('B')
            ..elementVoid('x-other-app', null, {'food': 'bard'})
            ..text('C');
        });
        print(root.outerHtml);
        expect(root.outerHtml,
            '<div id="app">A<x-app foo="bar"></x-app>B<x-other-app food="bard"></x-other-app>C</div>');
      });
    });

    group('non-empty root', () {
      Element root;

      setUp(() {
        idom
          ..elementOpen('div', null, {'id': 'app'})
          ..elementVoid('x-app', null, {'foo': 'bar'})
          ..elementOpen('x-other-app', null, {'food': 'bard'})
          ..text('Text!F')
          ..elementClose('x-other-app');
        root = idom.elementClose('div');
      });

      test('change text of child', () {
        idom.patch(root, () {
          idom
            ..elementVoid('x-app', null, {'foo': 'bar'})
            ..elementOpen('x-other-app', null, {'food': 'bard'})
            ..text('Changed text!')
            ..elementClose('x-other-app');
        });
        print(root.outerHtml);
        expect(root.children, hasLength(2));
        expect(root.children[0].localName, 'X-APP');
        expect(root.children[0].children, isEmpty);
        expect(root.children[1].localName, 'X-OTHER-APP');
        expect(root.children[1].childNodes, hasLength(1));
        expect(root.children[1].text, 'Changed text!');
      });
    });
  });
}
