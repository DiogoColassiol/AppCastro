import 'package:flutter/material.dart';
import 'package:project/database/db.dart';
import 'package:project/models/teses_model.dart';
import 'package:sqflite/sqflite.dart';

class TesesDAO extends ChangeNotifier {
  late Database db;
  List<TesesDB> _tesesList = [];
  List<TesesDB> get tesesList => _tesesList;

  TesesDAO() {
    _initRepository();
  }
  _initRepository() async {
    db = await DB.instance.database;
    await getTeses();
  }

  //create
  Future<void> insertTese(TesesDB tese) async {
    await db.insert('teses', tese.toMap());
    await getTeses();
  }

  //read
  Future<void> getTeses() async {
    db = await DB.instance.database;
    final teses = await db.query('teses');
    _tesesList = teses.map((map) => TesesDB.fromMap(map)).toList();
    notifyListeners();
  }

  //update
  Future<void> updateTese(TesesDB tese) async {
    await db.update(
      'table',
      tese.toMap(),
      where: 'id = ?',
      whereArgs: [tese.id],
    );
    await getTeses();
  }

  //delete
  Future<void> deleteTese(int id) async {
    await db.delete(
      'teses',
      where: 'id = ?',
      whereArgs: [id],
    );
    await getTeses();
  }
}
