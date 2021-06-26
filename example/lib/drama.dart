import 'package:resolver_mapper/annotations.dart';

@MapResolver()
class Drama {
  final double amountCollected;

  Drama(this.amountCollected);
}

@MapResolver()
class Foo {
  Foo();
}
