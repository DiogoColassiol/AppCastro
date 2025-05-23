import 'package:isar/isar.dart';
part 'regime.g.dart';

@Collection()
class Regime {
  Id id = Isar.autoIncrement;
  late String num;
  late String nome;
}
