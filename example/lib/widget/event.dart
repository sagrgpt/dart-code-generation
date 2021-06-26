import 'package:resolver_mapper/annotations.dart';

@MapResolver('TEST_EVENT')
class TestEvent {
  final String name;
  final String varPath;

  TestEvent(this.name, this.varPath);

  factory TestEvent.fromJson(Map<String, dynamic> json) =>
      TestEvent('name', '/toPath');
}

class DumbEvent {}
