import 'package:flutter/material.dart';
import 'package:project/database/db.dart';
import 'package:project/entity/documentos.dart';
import 'package:project/models/razoes_model.dart';
import 'package:sqflite/sqflite.dart';

class RegimeRepository extends ChangeNotifier {
  late Database db;
  List<Razoes> _regimesList = [];
  List<Razoes> get regimesList => _regimesList;

  RegimeRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getRegimes();
  }

  Future<void> _getRegimes() async {
    db = await DB.instance.database;
    List regimes = await db.query('regime', limit: 4);
    _regimesList = regimes.map((map) => Razoes.fromMap(map)).toList();
    notifyListeners();
  }

  setRegime(Documento doc) async {
    db = await DB.instance.database;
    db.update('regime', {
      'nome': doc.nome,
    });
    notifyListeners();
  }
}
