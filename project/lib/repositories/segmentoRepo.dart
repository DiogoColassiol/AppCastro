import 'package:flutter/material.dart';
import 'package:project/database/db.dart';
import 'package:project/entity/segmentos.dart';
import 'package:project/models/segmentos_model.dart';
import 'package:sqflite/sqflite.dart';

class SegmentoRepository extends ChangeNotifier {
  late Database db;
  List<Segmentos> _segmentosList = [];

  List<Segmentos> get segmentosList => _segmentosList;

  SegmentoRepository() {
    _initRepository();
  }
  _initRepository() async {
    await _getSegmentos();
  }

  Future<void> _getSegmentos() async {
    db = await DB.instance.database;
    final segs = await db.query('segmento', limit: 7);
    _segmentosList = segs.map((map) => Segmentos.fromMap(map)).toList();
    notifyListeners();
  }

  setSegmento(Segmento seg) async {
    db = await DB.instance.database;
    db.update('segmentos', {
      'nome': seg.nome,
    });
    notifyListeners();
  }
}
