import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/isar/models/documento/regime.dart';

class RegimeDataBase extends ChangeNotifier {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([RegimeDBSchema], directory: dir.path);
  }

  final List<RegimeDB> regimes = [];

  Future<void> addRegime(String numId, String nome, bool select) async {
    final newRegime = RegimeDB()
      ..numId = numId
      ..nome = nome
      ..selecionado = select;
    await isar.writeTxn(() => isar.regimeDBs.put(newRegime));

    readRegimes();
  }

  Future<void> readRegimes() async {
    List<RegimeDB> fetchRegimes = await isar.regimeDBs.where().findAll();
    regimes.clear();
    regimes.addAll(fetchRegimes);
    notifyListeners();
  }

  Future<void> updateRegime(int id, String newNome) async {
    final existeRegime = await isar.regimeDBs.get(id);
    if (existeRegime != null) {
      existeRegime.nome = newNome;
      await isar.writeTxn(() => isar.regimeDBs.put(existeRegime));
      await readRegimes();
    }
  }

  Future<void> deleteRegimes(int id) async {
    await isar.writeTxn(() => isar.regimeDBs.delete(id));
    await readRegimes();
  }
}
