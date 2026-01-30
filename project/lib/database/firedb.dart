import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/database/defaultData.dart';
import 'package:project/entity/segmentos.dart';

class FirestoreDB {
  FirestoreDB._();

  static final FirestoreDB instance = FirestoreDB._();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Cria as coleções e popula dados iniciais caso estejam vazias
  Future<void> initialize() async {
    final segmentosRef = _db.collection('segmento');
    final tesesRef = _db.collection('teses');

    final segmentosSnapshot = await segmentosRef.get();
    final tesesSnapshot = await tesesRef.get();

    if (segmentosSnapshot.docs.isEmpty) {
      for (final s in DefaultData.getSegmentos()) {
        await segmentosRef.add({
          'id': s.id,
          'nome': s.nome,
          'numero_teses': s.numTeses,
        });
      }
    }

    if (tesesSnapshot.docs.isEmpty) {
      for (final t in DefaultData.getTeses()) {
        await tesesRef.add({
          'id': t.id,
          'documentos': t.docs,
          'descricao': t.descricao,
          'legenda': t.legenda,
        });
      }
    }
  }

///////////////////////////// SEGMENTOS ///////////////////////////

  Future<List<Map<String, dynamic>>> getSegmentos() async {
    final snapshot =
        await _db.collection('segmento').orderBy('id', descending: false).get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  Future<void> addSegmento(Segmento seg) async {
    _db.collection('segmento').add({
      'id': seg.id,
      'nome': seg.nome,
      'numero_teses': seg.numTeses,
    });
  }

  Future<void> deleteSegmento(Segmento seg) async {
    final query = await getSegmentoQueryById(seg.id!);
    if (query.docs.isEmpty) return;

    final docId = query.docs.first.id;
    await _db.collection('segmento').doc(docId).delete();
  }

  Future<void> updateSegmento(Segmento seg) async {
    final query = await getSegmentoQueryById(seg.id!);

    _db.collection('segmento').doc(query.docs.first.id).update(seg.toMap());
  }

  //busca o segmento pela variavel id do seg
  Future<QuerySnapshot<Map<String, dynamic>>> getSegmentoQueryById(
      int id) async {
    return await _db
        .collection('segmento')
        .where('id', isEqualTo: id)
        .limit(1)
        .get();
  }

  //busca o maior id dos segmentos
  Future<int> getMaxSegmentoId() async {
    final query = await _db
        .collection('segmento')
        .orderBy('id', descending: true)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return 0; // nenhum segmento

    return query.docs.first.data()['id'] as int;
  }

  //////////////////////////// TESES /////////////////////////////

  Future<List<Map<String, dynamic>>> getTeses() async {
    final snapshot =
        await _db.collection('teses').orderBy('id', descending: false).get();
    return snapshot.docs.map((e) => e.data()).toList();
  }
}
