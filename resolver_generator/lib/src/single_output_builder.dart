import 'dart:async';

import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;
import 'package:resolver_mapper/annotations.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

class SingleOutputBuilder extends Builder {
  TypeChecker get _typeChecker => TypeChecker.fromRuntime(MapResolver);
  final _fileScope = Glob('lib/**');

  @override
  Map<String, List<String>> get buildExtensions => {
        r'$lib$': ['widget_resolver.dart'],
      };

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final classBuffer = StringBuffer();
    await for (final fileAsset in buildStep.findAssets(_fileScope)) {
      await buildForFiles(fileAsset, classBuffer, buildStep);
    }
    final output = _allFilesOutput(buildStep);
    return buildStep.writeAsString(output, classBuffer.toString());
  }

  void buildForFiles(
    AssetId inputId,
    StringBuffer classBuffer,
    BuildStep buildStep,
  ) async {
    final library = await _getLibraryFor(inputId, buildStep);
    library.annotatedWith(_typeChecker).forEach((annotatedElement) =>
        buildForAnnotatedElement(annotatedElement.element, classBuffer));
  }

  void buildForAnnotatedElement(
    Element element,
    StringBuffer classBuffer,
  ) {
    classBuffer.writeln("//${element.name}");
  }

  Future<LibraryReader> _getLibraryFor(
      AssetId assetId, BuildStep buildStep) async {
    final element = await buildStep.resolver.libraryFor(assetId);
    return LibraryReader(element);
  }

  AssetId _allFilesOutput(BuildStep buildStep) {
    return AssetId(
      buildStep.inputId.package,
      p.join('lib', 'widget_resolver.dart'),
    );
  }
}
