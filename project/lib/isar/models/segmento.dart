import 'package:isar/isar.dart';
part 'segmento.g.dart';

@Collection()
class Segmento {
  Id id = Isar.autoIncrement;
  late String num;
  late String nome;
}
