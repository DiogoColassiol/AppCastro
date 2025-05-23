import 'package:isar/isar.dart';
part 'segmento.g.dart';

@Collection()
class SegmentoDB {
  Id id = Isar.autoIncrement;
  late String numId;
  late String nome;
  late bool selecionado;
}
