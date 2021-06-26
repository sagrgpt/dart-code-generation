abstract class WidgetResolverMap {
  static Map<String, dynamic> _widgetResolvers = Map<String, dynamic>();

  static void addResolverForType<T>(
      String type,
      dynamic resolver,
      ) {
    _widgetResolvers[type] = resolver;
  }

  static void removeResolverForType(String type) {
    _widgetResolvers.remove(type);
  }

  static dynamic getResolverForType(String type) {
    return _widgetResolvers[type];
  }
}
