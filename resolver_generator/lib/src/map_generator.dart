import 'dart:async';

import 'package:build/build.dart';
import 'package:resolver_mapper/annotations.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

class MapGenerator extends GeneratorForAnnotation<MapResolver> {

  @override
  dynamic generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final classBuffer = StringBuffer();
    classBuffer.writeln('WidgetResolverMap.addResolverForType(');
    classBuffer.writeln('${annotation.read('name').stringValue.toUpperCase()},');
    classBuffer.writeln('(data) => ${element.name}.fromJson(data),');
    classBuffer.writeln(');');
    return classBuffer.toString();
  }
}
