import 'package:build/build.dart';
import 'package:resolver_mapper/annotations.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

class WidgetConstantGenerator extends GeneratorForAnnotation<MapResolver> {
  @override
  dynamic generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
//const String BOTTOM_SHEET = 'BOTTOM_SHEET';
    var output = 'const String [key] = \'[value]\';';
    final widgetName = annotation.read('name').stringValue;
    output = output.replaceAll('[key]', widgetName.toUpperCase());
    output = output.replaceAll('[value]', widgetName.toLowerCase());
    return output;
  }
}
