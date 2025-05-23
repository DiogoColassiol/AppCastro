import 'package:isar/isar.dart';
part 'tese.g.dart';

@Collection()
class TesesDB {
  Id id = Isar.autoIncrement;
  late String numId;
  late String docs;
  late String descricao;
  late String legenda;
}
