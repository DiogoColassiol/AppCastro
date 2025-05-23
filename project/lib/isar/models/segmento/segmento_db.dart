import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/isar/models/segmento/segmento.dart';

class SegmentoDataBase extends ChangeNotifier {
  static late Isar isar;
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([SegmentoDBSchema], directory: dir.path);
  }

  final List<SegmentoDB> segmentos = [];

  Future<void> addSegmento(String numId, String nome, bool select) async {
    final newSegmento = SegmentoDB()
      ..numId = numId
      ..nome = nome
      ..selecionado = select;
    await isar.writeTxn(() => isar.segmentoDBs.put(newSegmento));
  }

  Future<void> readSegmentos() async {
    List<SegmentoDB> fetchTeses = await isar.segmentoDBs.where().findAll();
    segmentos.clear();
    segmentos.addAll(fetchTeses);
    notifyListeners();
  }

  Future<void> updateSegmento(int id, String newNome) async {
    final existeSegmento = await isar.segmentoDBs.get(id);
    if (existeSegmento != null) {
      existeSegmento.nome = newNome;
      await isar.writeTxn(() => isar.segmentoDBs.put(existeSegmento));
      await readSegmentos();
    }
  }

  Future<void> deleteSegmento(int id) async {
    await isar.writeTxn(() => isar.segmentoDBs.delete(id));
    await readSegmentos();
  }
}
