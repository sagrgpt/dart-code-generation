import 'dart:async';

import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart';
import 'package:dart_style/src/dart_formatter.dart';

class AggregatorBuilder extends Builder {
  final _fileScope = Glob('lib/**');
  final _formatter = DartFormatter();
  final Map<String, Generator> generators;
  final String generatedExtension;
  final Generator bluePrintGenerator;
  final placeholderMap = <String, StringBuffer>{};

  AggregatorBuilder(
    this.generators, {
    @required this.bluePrintGenerator,
    @required this.generatedExtension,
  }) {
    generators.keys.forEach((key) => placeholderMap[key] = StringBuffer());
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        r'$lib$': [generatedExtension],
      };

  @override
  FutureOr<void> build(BuildStep buildStep) async {

    var output = await bluePrintGenerator.generate(null, buildStep);

    await for (final fileAsset in buildStep.findAssets(_fileScope)) {
      await buildForFiles(fileAsset, buildStep);
    }

    placeholderMap.keys.forEach((key) {
      output = output.replaceFirst(key, placeholderMap[key].toString());
    });
    output = _formatter.format(output);
    try {
      return buildStep.writeAsString(
        _getOutputAssetId(buildStep),
        output,
      );
    } catch(exception) {
      print('unable to write file reason: $exception');
    }
  }

  void buildForFiles(
    AssetId inputId,
    BuildStep buildStep,
  ) async {
    final library = await _getLibraryFor(inputId, buildStep);
    generators.keys.forEach((key) async {
      final output = await generators[key].generate(library, buildStep);
      placeholderMap[key].writeln(output);
    });

  }

  Future<LibraryReader> _getLibraryFor(
      AssetId assetId, BuildStep buildStep) async {
    final element = await buildStep.resolver.libraryFor(assetId);
    return LibraryReader(element);
  }

  AssetId _getOutputAssetId(BuildStep buildStep) {
    print('Package: ${buildStep.inputId.package}');
    print('Asset Path: ${buildStep.inputId.path}');
    print('Set Path: ${p.join('lib','widget','widget_factory.dart')}');
    return AssetId(
      buildStep.inputId.package,
      p.join('lib','widget','widget_factory.dart'),
    );
  }
}
