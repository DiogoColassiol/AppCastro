// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'segmento.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSegmentoDBCollection on Isar {
  IsarCollection<SegmentoDB> get segmentoDBs => this.collection();
}

const SegmentoDBSchema = CollectionSchema(
  name: r'SegmentoDB',
  id: -314411221102957105,
  properties: {
    r'nome': PropertySchema(
      id: 0,
      name: r'nome',
      type: IsarType.string,
    ),
    r'numId': PropertySchema(
      id: 1,
      name: r'numId',
      type: IsarType.string,
    ),
    r'selecionado': PropertySchema(
      id: 2,
      name: r'selecionado',
      type: IsarType.bool,
    )
  },
  estimateSize: _segmentoDBEstimateSize,
  serialize: _segmentoDBSerialize,
  deserialize: _segmentoDBDeserialize,
  deserializeProp: _segmentoDBDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _segmentoDBGetId,
  getLinks: _segmentoDBGetLinks,
  attach: _segmentoDBAttach,
  version: '3.1.0+1',
);

int _segmentoDBEstimateSize(
  SegmentoDB object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nome.length * 3;
  bytesCount += 3 + object.numId.length * 3;
  return bytesCount;
}

void _segmentoDBSerialize(
  SegmentoDB object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.nome);
  writer.writeString(offsets[1], object.numId);
  writer.writeBool(offsets[2], object.selecionado);
}

SegmentoDB _segmentoDBDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SegmentoDB();
  object.id = id;
  object.nome = reader.readString(offsets[0]);
  object.numId = reader.readString(offsets[1]);
  object.selecionado = reader.readBool(offsets[2]);
  return object;
}

P _segmentoDBDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _segmentoDBGetId(SegmentoDB object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _segmentoDBGetLinks(SegmentoDB object) {
  return [];
}

void _segmentoDBAttach(IsarCollection<dynamic> col, Id id, SegmentoDB object) {
  object.id = id;
}

extension SegmentoDBQueryWhereSort
    on QueryBuilder<SegmentoDB, SegmentoDB, QWhere> {
  QueryBuilder<SegmentoDB, SegmentoDB, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SegmentoDBQueryWhere
    on QueryBuilder<SegmentoDB, SegmentoDB, QWhereClause> {
  QueryBuilder<SegmentoDB, SegmentoDB, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SegmentoDBQueryFilter
    on QueryBuilder<SegmentoDB, SegmentoDB, QFilterCondition> {
  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> nomeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> nomeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> nomeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> nomeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> nomeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> nomeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> nomeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> nomeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nome',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> nomeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nome',
        value: '',
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> nomeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nome',
        value: '',
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> numIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> numIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> numIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> numIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> numIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'numId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> numIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'numId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> numIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'numId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> numIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'numId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition> numIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numId',
        value: '',
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition>
      numIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'numId',
        value: '',
      ));
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterFilterCondition>
      selecionadoEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selecionado',
        value: value,
      ));
    });
  }
}

extension SegmentoDBQueryObject
    on QueryBuilder<SegmentoDB, SegmentoDB, QFilterCondition> {}

extension SegmentoDBQueryLinks
    on QueryBuilder<SegmentoDB, SegmentoDB, QFilterCondition> {}

extension SegmentoDBQuerySortBy
    on QueryBuilder<SegmentoDB, SegmentoDB, QSortBy> {
  QueryBuilder<SegmentoDB, SegmentoDB, QAfterSortBy> sortByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterSortBy> sortByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterSortBy> sortByNumId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numId', Sort.asc);
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterSortBy> sortByNumIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numId', Sort.desc);
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterSortBy> sortBySelecionado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selecionado', Sort.asc);
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterSortBy> sortBySelecionadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selecionado', Sort.desc);
    });
  }
}

extension SegmentoDBQuerySortThenBy
    on QueryBuilder<SegmentoDB, SegmentoDB, QSortThenBy> {
  QueryBuilder<SegmentoDB, SegmentoDB, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterSortBy> thenByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterSortBy> thenByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterSortBy> thenByNumId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numId', Sort.asc);
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterSortBy> thenByNumIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numId', Sort.desc);
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterSortBy> thenBySelecionado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selecionado', Sort.asc);
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QAfterSortBy> thenBySelecionadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selecionado', Sort.desc);
    });
  }
}

extension SegmentoDBQueryWhereDistinct
    on QueryBuilder<SegmentoDB, SegmentoDB, QDistinct> {
  QueryBuilder<SegmentoDB, SegmentoDB, QDistinct> distinctByNome(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nome', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QDistinct> distinctByNumId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SegmentoDB, SegmentoDB, QDistinct> distinctBySelecionado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selecionado');
    });
  }
}

extension SegmentoDBQueryProperty
    on QueryBuilder<SegmentoDB, SegmentoDB, QQueryProperty> {
  QueryBuilder<SegmentoDB, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SegmentoDB, String, QQueryOperations> nomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nome');
    });
  }

  QueryBuilder<SegmentoDB, String, QQueryOperations> numIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numId');
    });
  }

  QueryBuilder<SegmentoDB, bool, QQueryOperations> selecionadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selecionado');
    });
  }
}
