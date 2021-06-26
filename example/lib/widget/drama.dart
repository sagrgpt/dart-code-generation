import 'package:annotator/annotations.dart';

@Analyse()
class Drama {
  final double amountCollected;

  Drama(this.amountCollected);

  factory Drama.fromJson(Map<String, dynamic> json) => Drama(12.1);
}

@Analyse()
class Foo {
  Foo();

  factory Foo.fromJson(Map<String, dynamic> json) => Foo();
}
