import 'dart:async';

import 'package:build/build.dart';
import 'package:resolver_mapper/annotations.dart';
import 'package:source_gen/source_gen.dart';

class ResolverMapGenerator extends Generator {
  TypeChecker get _typeChecker => TypeChecker.fromRuntime(MapResolver);

  static int _ctr = 0;

  @override
  FutureOr<String> generate(
    LibraryReader library,
    BuildStep buildStep,
  ) {
    print('Received called to resolver map generator: ${++_ctr}');
    var count = 0;
    for (var annotatedElement in library.annotatedWith(_typeChecker)) {
      count++;
    }

    return '''//Callback received for class ${library.classes.first.name}\/n
// Total number of annotated class found = $count''';
  }
}
