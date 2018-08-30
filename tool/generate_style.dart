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
  var htmlFile = new File(propertyListHtmlPath);
  var doc = html.parse(await htmlFile.readAsString(),
      sourceUrl: propertyListHtmlPath);

  // Extract the names of all possible properties.
  var properties = <String>[];
  //var descriptions = <String, String>{};
  var recases = <String, ReCase>{};
  var links = doc.getElementsByTagName('a');

  for (var link in links) {
    var href = link.attributes['href'] ?? '';

    if (href.startsWith('pr_') && !link.text.contains('@')) {
      properties.add(link.text);
      //descriptions.putIfAbsent(
      //    link.text, () => link.parent.parent.children[1].text);
      recases.putIfAbsent(link.text, () => new ReCase(link.text));
    }
  }

  var lib = new Library((b) {
    b.body.add(new Class((b) {
      b
        ..name = 'Style'
        ..docs.addAll([
          '/// A utility class that can be used to generate CSS styles.',
          '///',
          '/// AUTO-GENERATED. DO NOT MODIFY BY HAND.'
        ]);

      // Add String fields for each possible property.
      for (var property in properties) {
        b.fields.add(new Field((b) {
          b
            ..modifier = FieldModifier.final$
            ..name = recases[property].camelCase
            ..type = refer('String')
            ..docs.addAll([
              //'/// ${descriptions[property]}.',
              //'///',
              '/// Corresponds to the CSS property `$property`.',
            ]);
        }));

        // Next, create a CONST constructor that initializes each property.
        b.constructors.add(new Constructor((b) {
          b.constant = true;

          for (var property in properties) {
            b.optionalParameters.add(new Parameter((b) {
              b
                ..named = true
                ..name = recases[property].camelCase
                ..toThis = true;
            }));
          }
        }));

        // Next, create a `copyWith` method that can mutate styles.
        b.methods.add(new Method((b) {
          b
            ..name = 'copyWith'
            ..returns = refer('Style')
            ..body = new Block((b) {
              var named = <String, Expression>{};

              for (var property in properties) {
                var name = recases[property].camelCase;
                named[name] =
                    new CodeExpression(new Code('$name ?? this.$name'));
              }

              b.addExpression(refer('Style').newInstance([], named));
            });

          for (var property in properties) {
            b.optionalParameters.add(new Parameter((b) {
              b
                ..named = true
                ..name = recases[property].camelCase
                ..type = refer('String');
            }));
          }
        }));

        // Finally create a `compile` method.
        b.methods.add(new Method((b) {
          var values = <Expression, Expression>{};

          for (var property in properties) {
            values[literalString(property)] =
                refer(recases[property].camelCase);
          }

          b
            ..name = 'compile'
            ..returns = new TypeReference((b) {
              b
                ..symbol = 'Map'
                ..types.addAll([
                  refer('String'),
                  refer('String'),
                ]);
            })
            ..body = literalMap(values).returned.statement;
        }));
      }
    }));
  });

  var dartSource =
      new DartFormatter().format(lib.accept(new DartEmitter()).toString());

  var outFile = new File(styleFilePath);
  await outFile.writeAsString(dartSource);
  print('Wrote $styleFilePath');
}
