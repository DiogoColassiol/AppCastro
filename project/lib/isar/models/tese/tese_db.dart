import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/isar/models/tese/tese.dart';

class TeseDataBase extends ChangeNotifier {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([TesesDBSchema], directory: dir.path);
  }

  final List<TesesDB> teses = [];

  Future<void> addTese(
      String numId, String docs, String desc, String legenda) async {
    final newTese = TesesDB()
      ..numId = numId
      ..docs = docs
      ..descricao = desc
      ..legenda = legenda;

    await isar.writeTxn(() => isar.tesesDBs.put(newTese));

    readTeses();
  }

  Future<void> readTeses() async {
    List<TesesDB> fetchTeses = await isar.tesesDBs.where().findAll();
    teses.clear();
    teses.addAll(fetchTeses);
    notifyListeners();
  }

  Future<void> updateTese(int id, String newDescricao) async {
    final existeTese = await isar.tesesDBs.get(id);
    if (existeTese != null) {
      existeTese.descricao = newDescricao;
      await isar.writeTxn(() => isar.tesesDBs.put(existeTese));
      await readTeses();
    }
  }

  Future<void> deleteTese(int id) async {
    await isar.writeTxn(() => isar.tesesDBs.delete(id));
    await readTeses();
  }
}
