import 'package:resolver_mapper/widget_resolver_map.dart';
import 'index.dart';
//*******************************************
// GENERATED CODE - DO NOT MODIFY BY HAND
//*******************************************

const String DRAMA = 'drama';

const String FOO = 'foo';

const String TEST_EVENT = 'test_event';

class WidgetFactory {
  static void initialize() {
    WidgetResolverMap.addResolverForType(
      DRAMA,
      (data) => Drama.fromJson(data),
    );

    WidgetResolverMap.addResolverForType(
      FOO,
      (data) => Foo.fromJson(data),
    );

    WidgetResolverMap.addResolverForType(
      TEST_EVENT,
      (data) => TestEvent.fromJson(data),
    );
  }
}
