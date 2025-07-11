import 'package:flutter/material.dart';
import 'package:project/database/db.dart';
import 'package:project/models/razoes_model.dart';
import 'package:sqflite/sqflite.dart';

class RegimeDAO extends ChangeNotifier {
  late Database db;
  List<Razoes> _regimesList = [];
  List<Razoes> get regimesList => _regimesList;

  RegimeDAO() {
    _initRepository();
  }

  Future<void> _initRepository() async {
    db = await DB.instance.database;
    await getRegimes();
  }

  /// CREATE
  Future<void> insertRegime(Razoes regime) async {
    await db.insert('regime', regime.toMap());
    await getRegimes(); // atualiza lista
  }

  /// READ
  Future<void> getRegimes() async {
    final result = await db.query('regime', limit: 10);
    _regimesList = result.map((map) => Razoes.fromMap(map)).toList();
    notifyListeners();
  }

  /// UPDATE
  Future<void> updateRegime(Razoes regime) async {
    await db.update(
      'regime',
      regime.toMap(),
      where: 'id = ?',
      whereArgs: [regime.documento.id],
    );
    await getRegimes(); // atualiza lista
  }

  /// DELETE - Remover regime pelo ID
  Future<void> deleteRegime(int id) async {
    await db.delete(
      'regime',
      where: 'id = ?',
      whereArgs: [id],
    );
    await getRegimes(); // atualiza lista
  }

  Future<List<Razoes>> getList() async {
    final lista = getRegimes();

    return [];
  }
}
