import 'package:resolver_mapper/annotations.dart';

@MapResolver()
class TestEvent{
  final String name;
  final String varPath;

  TestEvent(this.name, this.varPath);
}

class DumbEvent{

}