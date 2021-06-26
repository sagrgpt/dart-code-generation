import 'package:build/build.dart';

import 'src/aggregate_builder.dart';
import 'src/class_name_generator.dart';

Builder analysisBuilder(BuilderOptions options) =>
    AggregateBuilder(ClassNameGenerator());
