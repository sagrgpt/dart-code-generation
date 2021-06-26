import 'dart:async';

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class WidgetFactoryBluePrintGenerator extends Generator {

    final bodyPlaceholder = '[bodyPlaceholder]';
    final constPlaceholder = '[constPlaceholder]';

  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) {
    final stringBuffer = StringBuffer();
    stringBuffer.writeln(
        'import \'package:resolver_mapper/widget_resolver_map.dart\';');
    stringBuffer.writeln('import \'index.dart\';');
    stringBuffer.writeln('//*******************************************');
    stringBuffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    stringBuffer.writeln('//*******************************************');
    stringBuffer.writeln(constPlaceholder);
    stringBuffer.writeln('class WidgetFactory {');
    stringBuffer.writeln('static void initialize() {');
    stringBuffer.writeln(bodyPlaceholder);
    stringBuffer.writeln('}');
    stringBuffer.writeln('}');
    return stringBuffer.toString();
  }
}