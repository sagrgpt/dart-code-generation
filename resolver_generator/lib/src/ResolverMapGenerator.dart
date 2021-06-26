import 'dart:async';

import 'package:build/build.dart';
import 'package:resolver_mapper/annotations.dart';
import 'package:source_gen/source_gen.dart';

class ResolverMapGenerator extends Generator {
  TypeChecker get _typeChecker => TypeChecker.fromRuntime(MapResolver);

  @override
  FutureOr<String> generate(
    LibraryReader library,
    BuildStep buildStep,
  ) {
    var count = 0;
    library.annotatedWith(_typeChecker).forEach((element) => count++);

    return "# Total number of annotated class found = $count";
  }
}
