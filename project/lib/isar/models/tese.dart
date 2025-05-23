import 'package:isar/isar.dart';
part 'tese.g.dart';

@Collection()
class Teses {
  Id id = Isar.autoIncrement;
  late String num;
  late String docs;
  late String legenda;
}
