import 'package:resolver_mapper/annotations.dart';

@MapResolver('DRAMA')
class Drama {
  final double amountCollected;

  Drama(this.amountCollected);

  factory Drama.fromJson(Map<String, dynamic> json) => Drama(12.1);
}

@MapResolver('FOO')
class Foo {
  Foo();

  factory Foo.fromJson(Map<String, dynamic> json) => Foo();
}
