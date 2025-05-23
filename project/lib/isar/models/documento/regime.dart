import 'package:isar/isar.dart';
part 'regime.g.dart';

@Collection()
class RegimeDB {
  Id id = Isar.autoIncrement;
  late String numId;
  late String nome;
  late bool selecionado;
}
