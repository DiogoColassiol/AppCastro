import 'package:flutter/material.dart';
import 'package:project/database/db.dart';

import 'package:project/models/segmentos_model.dart';
import 'package:sqflite/sqflite.dart';

class SegmentoDAO extends ChangeNotifier {
  late Database db;
  final ValueNotifier<List<SegmentoDB>> segmentosNotifier = ValueNotifier([]);
  List<SegmentoDB> get segmentosList => segmentosNotifier.value;

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
    segmentosNotifier.value =
        segs.map((map) => SegmentoDB.fromMap(map)).toList();
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
  Future<void> deleteSegmento(int cod) async {
    await db.delete(
      'segmento',
      where: 'codigo = ?',
      whereArgs: [cod],
    );
    await getSegmentos();
  }

  Future<int> getMaiorCod() async {
    db = await DB.instance.database;
    final result =
        await db.rawQuery('SELECT MAX(codigo) as max_codigo FROM segmento');
    final maxCod = result.first['max_codigo'] as int?;
    return maxCod ?? 0;
  }
}
