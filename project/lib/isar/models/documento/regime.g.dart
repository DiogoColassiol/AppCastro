// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regime.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRegimeDBCollection on Isar {
  IsarCollection<RegimeDB> get regimeDBs => this.collection();
}

const RegimeDBSchema = CollectionSchema(
  name: r'RegimeDB',
  id: -5209414690461943008,
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
  estimateSize: _regimeDBEstimateSize,
  serialize: _regimeDBSerialize,
  deserialize: _regimeDBDeserialize,
  deserializeProp: _regimeDBDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _regimeDBGetId,
  getLinks: _regimeDBGetLinks,
  attach: _regimeDBAttach,
  version: '3.1.0+1',
);

int _regimeDBEstimateSize(
  RegimeDB object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nome.length * 3;
  bytesCount += 3 + object.numId.length * 3;
  return bytesCount;
}

void _regimeDBSerialize(
  RegimeDB object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.nome);
  writer.writeString(offsets[1], object.numId);
  writer.writeBool(offsets[2], object.selecionado);
}

RegimeDB _regimeDBDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RegimeDB();
  object.id = id;
  object.nome = reader.readString(offsets[0]);
  object.numId = reader.readString(offsets[1]);
  object.selecionado = reader.readBool(offsets[2]);
  return object;
}

P _regimeDBDeserializeProp<P>(
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

Id _regimeDBGetId(RegimeDB object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _regimeDBGetLinks(RegimeDB object) {
  return [];
}

void _regimeDBAttach(IsarCollection<dynamic> col, Id id, RegimeDB object) {
  object.id = id;
}

extension RegimeDBQueryWhereSort on QueryBuilder<RegimeDB, RegimeDB, QWhere> {
  QueryBuilder<RegimeDB, RegimeDB, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RegimeDBQueryWhere on QueryBuilder<RegimeDB, RegimeDB, QWhereClause> {
  QueryBuilder<RegimeDB, RegimeDB, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<RegimeDB, RegimeDB, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QAfterWhereClause> idBetween(
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

extension RegimeDBQueryFilter
    on QueryBuilder<RegimeDB, RegimeDB, QFilterCondition> {
  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> nomeEqualTo(
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

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> nomeGreaterThan(
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

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> nomeLessThan(
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

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> nomeBetween(
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

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> nomeStartsWith(
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

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> nomeEndsWith(
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

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> nomeContains(
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

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> nomeMatches(
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

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> nomeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nome',
        value: '',
      ));
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> nomeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nome',
        value: '',
      ));
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> numIdEqualTo(
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

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> numIdGreaterThan(
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

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> numIdLessThan(
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

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> numIdBetween(
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

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> numIdStartsWith(
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

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> numIdEndsWith(
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

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> numIdContains(
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

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> numIdMatches(
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

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> numIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numId',
        value: '',
      ));
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> numIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'numId',
        value: '',
      ));
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QAfterFilterCondition> selecionadoEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selecionado',
        value: value,
      ));
    });
  }
}

extension RegimeDBQueryObject
    on QueryBuilder<RegimeDB, RegimeDB, QFilterCondition> {}

extension RegimeDBQueryLinks
    on QueryBuilder<RegimeDB, RegimeDB, QFilterCondition> {}

extension RegimeDBQuerySortBy on QueryBuilder<RegimeDB, RegimeDB, QSortBy> {
  QueryBuilder<RegimeDB, RegimeDB, QAfterSortBy> sortByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QAfterSortBy> sortByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QAfterSortBy> sortByNumId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numId', Sort.asc);
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QAfterSortBy> sortByNumIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numId', Sort.desc);
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QAfterSortBy> sortBySelecionado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selecionado', Sort.asc);
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QAfterSortBy> sortBySelecionadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selecionado', Sort.desc);
    });
  }
}

extension RegimeDBQuerySortThenBy
    on QueryBuilder<RegimeDB, RegimeDB, QSortThenBy> {
  QueryBuilder<RegimeDB, RegimeDB, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QAfterSortBy> thenByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QAfterSortBy> thenByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QAfterSortBy> thenByNumId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numId', Sort.asc);
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QAfterSortBy> thenByNumIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numId', Sort.desc);
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QAfterSortBy> thenBySelecionado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selecionado', Sort.asc);
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QAfterSortBy> thenBySelecionadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selecionado', Sort.desc);
    });
  }
}

extension RegimeDBQueryWhereDistinct
    on QueryBuilder<RegimeDB, RegimeDB, QDistinct> {
  QueryBuilder<RegimeDB, RegimeDB, QDistinct> distinctByNome(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nome', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QDistinct> distinctByNumId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RegimeDB, RegimeDB, QDistinct> distinctBySelecionado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selecionado');
    });
  }
}

extension RegimeDBQueryProperty
    on QueryBuilder<RegimeDB, RegimeDB, QQueryProperty> {
  QueryBuilder<RegimeDB, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RegimeDB, String, QQueryOperations> nomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nome');
    });
  }

  QueryBuilder<RegimeDB, String, QQueryOperations> numIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numId');
    });
  }

  QueryBuilder<RegimeDB, bool, QQueryOperations> selecionadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selecionado');
    });
  }
}
