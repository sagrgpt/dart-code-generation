import 'dart:async';

import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart';

class AggregateBuilder extends Builder {
  final _fileScope = Glob('lib/**');
  final outputBuffer = StringBuffer();
  final Generator generator;
  final placeholderMap = <String, StringBuffer>{};

  AggregateBuilder(this.generator);

  @override
  Map<String, List<String>> get buildExtensions => {
        r'$lib$': ['analysis.gen.txt'],
      };

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    outputBuffer.clear();
    _addGeneratedCodeAlert(outputBuffer);
    await _createContentForEachFileInScope(buildStep);
    return _writeToSingleAsset(buildStep);
  }

  Future<void> _createContentForEachFileInScope(BuildStep buildStep) async {
    await for (final fileAsset in buildStep.findAssets(_fileScope)) {
      await buildForFiles(fileAsset, buildStep, outputBuffer);
    }
  }

  void buildForFiles(
    AssetId inputId,
    BuildStep buildStep,
    StringBuffer outputBuffer,
  ) async {
    final library = await _getLibraryFor(inputId, buildStep);
    final output = await generator.generate(library, buildStep);
    outputBuffer.writeln(output);
  }

  FutureOr<void> _writeToSingleAsset(BuildStep buildStep) {
    try {
      return buildStep.writeAsString(
        _getOutputAssetId(buildStep),
        outputBuffer.toString(),
      );
    } catch (exception) {
      print('unable to write file reason: $exception');
    }
  }

  Future<LibraryReader> _getLibraryFor(
      AssetId assetId, BuildStep buildStep) async {
    final element = await buildStep.resolver.libraryFor(assetId);
    return LibraryReader(element);
  }

  AssetId _getOutputAssetId(BuildStep buildStep) {
    print('Package: ${buildStep.inputId.package}');
    print('Asset Path: ${buildStep.inputId.path}');
    print('Set Path: ${p.join('lib', 'analysis.gen.txt')}');
    return AssetId(
      buildStep.inputId.package,
      p.join('lib', 'analysis.gen.txt'),
    );
  }

  void _addGeneratedCodeAlert(StringBuffer outputBuffer) {
    outputBuffer.writeln("//*******************************************");
    outputBuffer.writeln("// GENERATED CODE - DO NOT MODIFY BY HAND");
    outputBuffer.writeln("//*******************************************");
  }
}
