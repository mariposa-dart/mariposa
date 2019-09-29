import 'dart:collection';
import 'dart:io';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:html/parser.dart' as html;
import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';

main() async {
  var thisScript = p.fromUri(Platform.script);
  var propertyListHtmlPath =
      p.join(p.dirname(thisScript), 'css_property_list.html');
  var libPath = p.join(p.dirname(p.dirname(thisScript)), 'lib');
  var styleFilePath = p.join(libPath, 'src', 'elements', 'style.dart');

  // Read in the HTML file.
  var htmlFile = File(propertyListHtmlPath);
  var doc = html.parse(await htmlFile.readAsString(),
      sourceUrl: propertyListHtmlPath);

  // Extract the names of all possible properties.
  var properties = SplayTreeSet<String>();
  // properties.addAll([
  //   'animation',
  //   'animation-duration',
  //   'animation-name',
  //   'animation-timing-function',
  //   'animation-delay',
  //   'animation-iteration-count',
  //   'animation-direction',
  //   'animation-fill-mode'
  // ]);
  //var descriptions = <String, String>{};
  var recases = <String, ReCase>{};
  var valid = RegExp(r'^[a-z-]+$');
  var links = doc.querySelector('.index').getElementsByTagName('ul li a');
  // var links = doc.getElementsByTagName('a');

  var change = {'in': r'in_'};

  for (var link in links) {
    // var href = link.attributes['href'] ?? '';

    // if (href.startsWith('pr_') && !link.text.contains('@')) {
    if (valid.hasMatch(link.text)) {
      properties.add(link.text);
      //descriptions.putIfAbsent(
      //    link.text, () => link.parent.parent.children[1].text);
    }
  }

  for (var property in properties) {
    recases.putIfAbsent(property, () => ReCase(property));
  }

  String camel(String name) {
    return change[name] ?? recases[name].camelCase;
  }

  var lib = Library((b) {
    b.body.add(Class((b) {
      b
        ..name = 'Style'
        ..docs.addAll([
          '/// A utility class that can be used to generate CSS styles.',
          '///',
          '/// AUTO-GENERATED. DO NOT MODIFY BY HAND.'
        ]);

      // Add String fields for each possible property.
      for (var property in properties) {
        b.fields.add(Field((b) {
          b
            ..modifier = FieldModifier.final$
            ..name = camel(property)
            ..type = refer('String')
            ..docs.addAll([
              //'/// ${descriptions[property]}.',
              //'///',
              '/// Corresponds to the CSS property `$property`.',
            ]);
        }));
      }

      // Next, create a CONST constructor that initializes each property.
      b.constructors.add(Constructor((b) {
        b.constant = true;

        for (var property in properties) {
          b.optionalParameters.add(Parameter((b) {
            b
              ..named = true
              ..name = camel(property)
              ..toThis = true;
          }));
        }
      }));

      // Next, create a `copyWith` method that can mutate styles.
      b.methods.add(Method((b) {
        b
          ..name = 'copyWith'
          ..returns = refer('Style')
          ..body = Block((b) {
            var named = <String, Expression>{};

            for (var property in properties) {
              var name = camel(property);
              named[name] = CodeExpression(Code('$name ?? this.$name'));
            }

            b.addExpression(refer('Style').newInstance([], named).returned);
          });

        for (var property in properties) {
          b.optionalParameters.add(Parameter((b) {
            b
              ..named = true
              ..name = camel(property)
              ..type = refer('String');
          }));
        }
      }));

      // Finally create a `compile` method.
      b.methods.add(Method((b) {
        var values = <Expression, Expression>{};

        for (var property in properties) {
          values[literalString(property)] = refer(camel(property));
        }

        b
          ..name = 'compile'
          ..returns = TypeReference((b) {
            b
              ..symbol = 'Map'
              ..types.addAll([
                refer('String'),
                refer('String'),
              ]);
          })
          ..body = literalMap(values).returned.statement;
      }));
    }));
  });

  var dartSource = lib.accept(DartEmitter()).toString();
  dartSource = DartFormatter().format(dartSource);

  var outFile = File(styleFilePath);
  await outFile.writeAsString(dartSource);
  print('Wrote $styleFilePath');
}
