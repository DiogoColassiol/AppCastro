// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tese.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTesesDBCollection on Isar {
  IsarCollection<TesesDB> get tesesDBs => this.collection();
}

const TesesDBSchema = CollectionSchema(
  name: r'TesesDB',
  id: -4980810382166181765,
  properties: {
    r'descricao': PropertySchema(
      id: 0,
      name: r'descricao',
      type: IsarType.string,
    ),
    r'docs': PropertySchema(
      id: 1,
      name: r'docs',
      type: IsarType.string,
    ),
    r'legenda': PropertySchema(
      id: 2,
      name: r'legenda',
      type: IsarType.string,
    ),
    r'numId': PropertySchema(
      id: 3,
      name: r'numId',
      type: IsarType.string,
    )
  },
  estimateSize: _tesesDBEstimateSize,
  serialize: _tesesDBSerialize,
  deserialize: _tesesDBDeserialize,
  deserializeProp: _tesesDBDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _tesesDBGetId,
  getLinks: _tesesDBGetLinks,
  attach: _tesesDBAttach,
  version: '3.1.0+1',
);

int _tesesDBEstimateSize(
  TesesDB object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.descricao.length * 3;
  bytesCount += 3 + object.docs.length * 3;
  bytesCount += 3 + object.legenda.length * 3;
  bytesCount += 3 + object.numId.length * 3;
  return bytesCount;
}

void _tesesDBSerialize(
  TesesDB object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.descricao);
  writer.writeString(offsets[1], object.docs);
  writer.writeString(offsets[2], object.legenda);
  writer.writeString(offsets[3], object.numId);
}

TesesDB _tesesDBDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TesesDB();
  object.descricao = reader.readString(offsets[0]);
  object.docs = reader.readString(offsets[1]);
  object.id = id;
  object.legenda = reader.readString(offsets[2]);
  object.numId = reader.readString(offsets[3]);
  return object;
}

P _tesesDBDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _tesesDBGetId(TesesDB object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _tesesDBGetLinks(TesesDB object) {
  return [];
}

void _tesesDBAttach(IsarCollection<dynamic> col, Id id, TesesDB object) {
  object.id = id;
}

extension TesesDBQueryWhereSort on QueryBuilder<TesesDB, TesesDB, QWhere> {
  QueryBuilder<TesesDB, TesesDB, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TesesDBQueryWhere on QueryBuilder<TesesDB, TesesDB, QWhereClause> {
  QueryBuilder<TesesDB, TesesDB, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<TesesDB, TesesDB, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterWhereClause> idBetween(
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

extension TesesDBQueryFilter
    on QueryBuilder<TesesDB, TesesDB, QFilterCondition> {
  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> descricaoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descricao',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> descricaoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'descricao',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> descricaoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'descricao',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> descricaoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'descricao',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> descricaoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'descricao',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> descricaoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'descricao',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> descricaoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'descricao',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> descricaoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'descricao',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> descricaoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descricao',
        value: '',
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> descricaoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'descricao',
        value: '',
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> docsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'docs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> docsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'docs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> docsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'docs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> docsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'docs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> docsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'docs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> docsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'docs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> docsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'docs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> docsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'docs',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> docsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'docs',
        value: '',
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> docsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'docs',
        value: '',
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> legendaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'legenda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> legendaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'legenda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> legendaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'legenda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> legendaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'legenda',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> legendaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'legenda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> legendaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'legenda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> legendaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'legenda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> legendaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'legenda',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> legendaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'legenda',
        value: '',
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> legendaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'legenda',
        value: '',
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> numIdEqualTo(
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

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> numIdGreaterThan(
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

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> numIdLessThan(
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

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> numIdBetween(
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

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> numIdStartsWith(
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

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> numIdEndsWith(
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

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> numIdContains(
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

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> numIdMatches(
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

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> numIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numId',
        value: '',
      ));
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterFilterCondition> numIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'numId',
        value: '',
      ));
    });
  }
}

extension TesesDBQueryObject
    on QueryBuilder<TesesDB, TesesDB, QFilterCondition> {}

extension TesesDBQueryLinks
    on QueryBuilder<TesesDB, TesesDB, QFilterCondition> {}

extension TesesDBQuerySortBy on QueryBuilder<TesesDB, TesesDB, QSortBy> {
  QueryBuilder<TesesDB, TesesDB, QAfterSortBy> sortByDescricao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descricao', Sort.asc);
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterSortBy> sortByDescricaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descricao', Sort.desc);
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterSortBy> sortByDocs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docs', Sort.asc);
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterSortBy> sortByDocsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docs', Sort.desc);
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterSortBy> sortByLegenda() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'legenda', Sort.asc);
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterSortBy> sortByLegendaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'legenda', Sort.desc);
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterSortBy> sortByNumId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numId', Sort.asc);
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterSortBy> sortByNumIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numId', Sort.desc);
    });
  }
}

extension TesesDBQuerySortThenBy
    on QueryBuilder<TesesDB, TesesDB, QSortThenBy> {
  QueryBuilder<TesesDB, TesesDB, QAfterSortBy> thenByDescricao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descricao', Sort.asc);
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterSortBy> thenByDescricaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descricao', Sort.desc);
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterSortBy> thenByDocs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docs', Sort.asc);
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterSortBy> thenByDocsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docs', Sort.desc);
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterSortBy> thenByLegenda() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'legenda', Sort.asc);
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterSortBy> thenByLegendaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'legenda', Sort.desc);
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterSortBy> thenByNumId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numId', Sort.asc);
    });
  }

  QueryBuilder<TesesDB, TesesDB, QAfterSortBy> thenByNumIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numId', Sort.desc);
    });
  }
}

extension TesesDBQueryWhereDistinct
    on QueryBuilder<TesesDB, TesesDB, QDistinct> {
  QueryBuilder<TesesDB, TesesDB, QDistinct> distinctByDescricao(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'descricao', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TesesDB, TesesDB, QDistinct> distinctByDocs(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'docs', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TesesDB, TesesDB, QDistinct> distinctByLegenda(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'legenda', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TesesDB, TesesDB, QDistinct> distinctByNumId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numId', caseSensitive: caseSensitive);
    });
  }
}

extension TesesDBQueryProperty
    on QueryBuilder<TesesDB, TesesDB, QQueryProperty> {
  QueryBuilder<TesesDB, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TesesDB, String, QQueryOperations> descricaoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descricao');
    });
  }

  QueryBuilder<TesesDB, String, QQueryOperations> docsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'docs');
    });
  }

  QueryBuilder<TesesDB, String, QQueryOperations> legendaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'legenda');
    });
  }

  QueryBuilder<TesesDB, String, QQueryOperations> numIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numId');
    });
  }
}
