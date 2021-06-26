import 'package:build/build.dart';
import 'package:resolver_generator/src/map_generator.dart';
import 'package:resolver_generator/src/single_output_builder.dart';
import 'package:resolver_generator/src/widget_constant_generator.dart';
import 'package:resolver_generator/src/widget_factory_blueprint_generator.dart';

Builder singleBuilder(BuilderOptions options) => AggregatorBuilder(
      {
        '[bodyPlaceholder]': MapGenerator(),
        '[constPlaceholder]': WidgetConstantGenerator(),
      },
      bluePrintGenerator: WidgetFactoryBluePrintGenerator(),
      generatedExtension: 'widget/widget_factory.dart',
    );
