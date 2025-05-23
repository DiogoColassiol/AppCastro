// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tese.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTesesCollection on Isar {
  IsarCollection<Teses> get teses => this.collection();
}

const TesesSchema = CollectionSchema(
  name: r'Teses',
  id: 681162374142823920,
  properties: {
    r'docs': PropertySchema(
      id: 0,
      name: r'docs',
      type: IsarType.string,
    ),
    r'legenda': PropertySchema(
      id: 1,
      name: r'legenda',
      type: IsarType.string,
    ),
    r'num': PropertySchema(
      id: 2,
      name: r'num',
      type: IsarType.string,
    )
  },
  estimateSize: _tesesEstimateSize,
  serialize: _tesesSerialize,
  deserialize: _tesesDeserialize,
  deserializeProp: _tesesDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _tesesGetId,
  getLinks: _tesesGetLinks,
  attach: _tesesAttach,
  version: '3.1.0+1',
);

int _tesesEstimateSize(
  Teses object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.docs.length * 3;
  bytesCount += 3 + object.legenda.length * 3;
  bytesCount += 3 + object.num.length * 3;
  return bytesCount;
}

void _tesesSerialize(
  Teses object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.docs);
  writer.writeString(offsets[1], object.legenda);
  writer.writeString(offsets[2], object.num);
}

Teses _tesesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Teses();
  object.docs = reader.readString(offsets[0]);
  object.id = id;
  object.legenda = reader.readString(offsets[1]);
  object.num = reader.readString(offsets[2]);
  return object;
}

P _tesesDeserializeProp<P>(
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _tesesGetId(Teses object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _tesesGetLinks(Teses object) {
  return [];
}

void _tesesAttach(IsarCollection<dynamic> col, Id id, Teses object) {
  object.id = id;
}

extension TesesQueryWhereSort on QueryBuilder<Teses, Teses, QWhere> {
  QueryBuilder<Teses, Teses, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TesesQueryWhere on QueryBuilder<Teses, Teses, QWhereClause> {
  QueryBuilder<Teses, Teses, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Teses, Teses, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Teses, Teses, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Teses, Teses, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Teses, Teses, QAfterWhereClause> idBetween(
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

extension TesesQueryFilter on QueryBuilder<Teses, Teses, QFilterCondition> {
  QueryBuilder<Teses, Teses, QAfterFilterCondition> docsEqualTo(
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

  QueryBuilder<Teses, Teses, QAfterFilterCondition> docsGreaterThan(
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

  QueryBuilder<Teses, Teses, QAfterFilterCondition> docsLessThan(
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

  QueryBuilder<Teses, Teses, QAfterFilterCondition> docsBetween(
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

  QueryBuilder<Teses, Teses, QAfterFilterCondition> docsStartsWith(
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

  QueryBuilder<Teses, Teses, QAfterFilterCondition> docsEndsWith(
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

  QueryBuilder<Teses, Teses, QAfterFilterCondition> docsContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'docs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Teses, Teses, QAfterFilterCondition> docsMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'docs',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Teses, Teses, QAfterFilterCondition> docsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'docs',
        value: '',
      ));
    });
  }

  QueryBuilder<Teses, Teses, QAfterFilterCondition> docsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'docs',
        value: '',
      ));
    });
  }

  QueryBuilder<Teses, Teses, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Teses, Teses, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Teses, Teses, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Teses, Teses, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Teses, Teses, QAfterFilterCondition> legendaEqualTo(
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

  QueryBuilder<Teses, Teses, QAfterFilterCondition> legendaGreaterThan(
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

  QueryBuilder<Teses, Teses, QAfterFilterCondition> legendaLessThan(
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

  QueryBuilder<Teses, Teses, QAfterFilterCondition> legendaBetween(
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

  QueryBuilder<Teses, Teses, QAfterFilterCondition> legendaStartsWith(
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

  QueryBuilder<Teses, Teses, QAfterFilterCondition> legendaEndsWith(
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

  QueryBuilder<Teses, Teses, QAfterFilterCondition> legendaContains(
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

  QueryBuilder<Teses, Teses, QAfterFilterCondition> legendaMatches(
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

  QueryBuilder<Teses, Teses, QAfterFilterCondition> legendaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'legenda',
        value: '',
      ));
    });
  }

  QueryBuilder<Teses, Teses, QAfterFilterCondition> legendaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'legenda',
        value: '',
      ));
    });
  }

  QueryBuilder<Teses, Teses, QAfterFilterCondition> numEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'num',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Teses, Teses, QAfterFilterCondition> numGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'num',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Teses, Teses, QAfterFilterCondition> numLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'num',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Teses, Teses, QAfterFilterCondition> numBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'num',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Teses, Teses, QAfterFilterCondition> numStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'num',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Teses, Teses, QAfterFilterCondition> numEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'num',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Teses, Teses, QAfterFilterCondition> numContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'num',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Teses, Teses, QAfterFilterCondition> numMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'num',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Teses, Teses, QAfterFilterCondition> numIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'num',
        value: '',
      ));
    });
  }

  QueryBuilder<Teses, Teses, QAfterFilterCondition> numIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'num',
        value: '',
      ));
    });
  }
}

extension TesesQueryObject on QueryBuilder<Teses, Teses, QFilterCondition> {}

extension TesesQueryLinks on QueryBuilder<Teses, Teses, QFilterCondition> {}

extension TesesQuerySortBy on QueryBuilder<Teses, Teses, QSortBy> {
  QueryBuilder<Teses, Teses, QAfterSortBy> sortByDocs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docs', Sort.asc);
    });
  }

  QueryBuilder<Teses, Teses, QAfterSortBy> sortByDocsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docs', Sort.desc);
    });
  }

  QueryBuilder<Teses, Teses, QAfterSortBy> sortByLegenda() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'legenda', Sort.asc);
    });
  }

  QueryBuilder<Teses, Teses, QAfterSortBy> sortByLegendaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'legenda', Sort.desc);
    });
  }

  QueryBuilder<Teses, Teses, QAfterSortBy> sortByNum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'num', Sort.asc);
    });
  }

  QueryBuilder<Teses, Teses, QAfterSortBy> sortByNumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'num', Sort.desc);
    });
  }
}

extension TesesQuerySortThenBy on QueryBuilder<Teses, Teses, QSortThenBy> {
  QueryBuilder<Teses, Teses, QAfterSortBy> thenByDocs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docs', Sort.asc);
    });
  }

  QueryBuilder<Teses, Teses, QAfterSortBy> thenByDocsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docs', Sort.desc);
    });
  }

  QueryBuilder<Teses, Teses, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Teses, Teses, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Teses, Teses, QAfterSortBy> thenByLegenda() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'legenda', Sort.asc);
    });
  }

  QueryBuilder<Teses, Teses, QAfterSortBy> thenByLegendaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'legenda', Sort.desc);
    });
  }

  QueryBuilder<Teses, Teses, QAfterSortBy> thenByNum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'num', Sort.asc);
    });
  }

  QueryBuilder<Teses, Teses, QAfterSortBy> thenByNumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'num', Sort.desc);
    });
  }
}

extension TesesQueryWhereDistinct on QueryBuilder<Teses, Teses, QDistinct> {
  QueryBuilder<Teses, Teses, QDistinct> distinctByDocs(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'docs', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Teses, Teses, QDistinct> distinctByLegenda(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'legenda', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Teses, Teses, QDistinct> distinctByNum(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'num', caseSensitive: caseSensitive);
    });
  }
}

extension TesesQueryProperty on QueryBuilder<Teses, Teses, QQueryProperty> {
  QueryBuilder<Teses, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Teses, String, QQueryOperations> docsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'docs');
    });
  }

  QueryBuilder<Teses, String, QQueryOperations> legendaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'legenda');
    });
  }

  QueryBuilder<Teses, String, QQueryOperations> numProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'num');
    });
  }
}
