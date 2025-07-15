import 'package:flutter/material.dart';
import 'package:project/database/db.dart';

import 'package:project/models/segmentos_model.dart';
import 'package:sqflite/sqflite.dart';

class SegmentoDAO extends ChangeNotifier {
  late Database db;
  List<SegmentoDB> _segmentosList = [];
  List<SegmentoDB> get segmentosList => _segmentosList;

  SegmentoDAO() {
    _initRepository();
  }
  _initRepository() async {
    db = await DB.instance.database;
    await getSegmentos();
  }

//create
  Future<void> insertSegmento(SegmentoDB segmento) async {
    await db.insert('segmento', segmento.toMap());
    await getSegmentos();
  }

//read
  Future<void> getSegmentos() async {
    db = await DB.instance.database;
    final segs = await db.query('segmento');
    _segmentosList = segs.map((map) => SegmentoDB.fromMap(map)).toList();
    notifyListeners();
  }

//update
  Future<void> updateSegmento(SegmentoDB segmento) async {
    await db.update(
      'segmento',
      segmento.toMap(),
      where: 'id = ?',
      whereArgs: [segmento.id],
    );
    await getSegmentos();
  }

//delete
  Future<void> deleteSegmento(int id) async {
    await db.delete(
      'segmento',
      where: 'id = ?',
      whereArgs: [id],
    );
    await getSegmentos();
  }
}
