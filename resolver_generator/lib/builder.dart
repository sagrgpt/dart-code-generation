import 'package:build/build.dart';
import 'package:resolver_generator/src/ResolverMapGenerator.dart';
import 'package:resolver_generator/src/single_output_builder.dart';
import 'package:source_gen/source_gen.dart';

Builder resolverMapBuilder(BuilderOptions options) => LibraryBuilder(
      ResolverMapGenerator(),
      generatedExtension: '.resolver.dart',
    );

Builder singleBuilder(BuilderOptions options) => SingleOutputBuilder();
