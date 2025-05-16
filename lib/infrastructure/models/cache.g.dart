// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCacheCollection on Isar {
  IsarCollection<Cache> get caches => this.collection();
}

const CacheSchema = CollectionSchema(
  name: r'Cache',
  id: 1541975981581312059,
  properties: {
    r'foods': PropertySchema(
      id: 0,
      name: r'foods',
      type: IsarType.objectList,
      target: r'Food',
    ),
    r'searchTerm': PropertySchema(
      id: 1,
      name: r'searchTerm',
      type: IsarType.string,
    )
  },
  estimateSize: _cacheEstimateSize,
  serialize: _cacheSerialize,
  deserialize: _cacheDeserialize,
  deserializeProp: _cacheDeserializeProp,
  idName: r'id',
  indexes: {
    r'searchTerm': IndexSchema(
      id: 6747083501682260651,
      name: r'searchTerm',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'searchTerm',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'Food': FoodSchema},
  getId: _cacheGetId,
  getLinks: _cacheGetLinks,
  attach: _cacheAttach,
  version: '3.1.8',
);

int _cacheEstimateSize(
  Cache object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.foods;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[Food]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += FoodSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.searchTerm;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _cacheSerialize(
  Cache object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<Food>(
    offsets[0],
    allOffsets,
    FoodSchema.serialize,
    object.foods,
  );
  writer.writeString(offsets[1], object.searchTerm);
}

Cache _cacheDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Cache();
  object.foods = reader.readObjectList<Food>(
    offsets[0],
    FoodSchema.deserialize,
    allOffsets,
    Food(),
  );
  object.id = id;
  object.searchTerm = reader.readStringOrNull(offsets[1]);
  return object;
}

P _cacheDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<Food>(
        offset,
        FoodSchema.deserialize,
        allOffsets,
        Food(),
      )) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cacheGetId(Cache object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cacheGetLinks(Cache object) {
  return [];
}

void _cacheAttach(IsarCollection<dynamic> col, Id id, Cache object) {
  object.id = id;
}

extension CacheQueryWhereSort on QueryBuilder<Cache, Cache, QWhere> {
  QueryBuilder<Cache, Cache, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CacheQueryWhere on QueryBuilder<Cache, Cache, QWhereClause> {
  QueryBuilder<Cache, Cache, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Cache, Cache, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Cache, Cache, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Cache, Cache, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Cache, Cache, QAfterWhereClause> idBetween(
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

  QueryBuilder<Cache, Cache, QAfterWhereClause> searchTermIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'searchTerm',
        value: [null],
      ));
    });
  }

  QueryBuilder<Cache, Cache, QAfterWhereClause> searchTermIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchTerm',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Cache, Cache, QAfterWhereClause> searchTermEqualTo(
      String? searchTerm) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'searchTerm',
        value: [searchTerm],
      ));
    });
  }

  QueryBuilder<Cache, Cache, QAfterWhereClause> searchTermNotEqualTo(
      String? searchTerm) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchTerm',
              lower: [],
              upper: [searchTerm],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchTerm',
              lower: [searchTerm],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchTerm',
              lower: [searchTerm],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchTerm',
              lower: [],
              upper: [searchTerm],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CacheQueryFilter on QueryBuilder<Cache, Cache, QFilterCondition> {
  QueryBuilder<Cache, Cache, QAfterFilterCondition> foodsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'foods',
      ));
    });
  }

  QueryBuilder<Cache, Cache, QAfterFilterCondition> foodsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'foods',
      ));
    });
  }

  QueryBuilder<Cache, Cache, QAfterFilterCondition> foodsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'foods',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Cache, Cache, QAfterFilterCondition> foodsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'foods',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Cache, Cache, QAfterFilterCondition> foodsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'foods',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Cache, Cache, QAfterFilterCondition> foodsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'foods',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Cache, Cache, QAfterFilterCondition> foodsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'foods',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Cache, Cache, QAfterFilterCondition> foodsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'foods',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Cache, Cache, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Cache, Cache, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Cache, Cache, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Cache, Cache, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Cache, Cache, QAfterFilterCondition> searchTermIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'searchTerm',
      ));
    });
  }

  QueryBuilder<Cache, Cache, QAfterFilterCondition> searchTermIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'searchTerm',
      ));
    });
  }

  QueryBuilder<Cache, Cache, QAfterFilterCondition> searchTermEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchTerm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cache, Cache, QAfterFilterCondition> searchTermGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'searchTerm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cache, Cache, QAfterFilterCondition> searchTermLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'searchTerm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cache, Cache, QAfterFilterCondition> searchTermBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'searchTerm',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cache, Cache, QAfterFilterCondition> searchTermStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'searchTerm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cache, Cache, QAfterFilterCondition> searchTermEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'searchTerm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cache, Cache, QAfterFilterCondition> searchTermContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'searchTerm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cache, Cache, QAfterFilterCondition> searchTermMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'searchTerm',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cache, Cache, QAfterFilterCondition> searchTermIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchTerm',
        value: '',
      ));
    });
  }

  QueryBuilder<Cache, Cache, QAfterFilterCondition> searchTermIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'searchTerm',
        value: '',
      ));
    });
  }
}

extension CacheQueryObject on QueryBuilder<Cache, Cache, QFilterCondition> {
  QueryBuilder<Cache, Cache, QAfterFilterCondition> foodsElement(
      FilterQuery<Food> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'foods');
    });
  }
}

extension CacheQueryLinks on QueryBuilder<Cache, Cache, QFilterCondition> {}

extension CacheQuerySortBy on QueryBuilder<Cache, Cache, QSortBy> {
  QueryBuilder<Cache, Cache, QAfterSortBy> sortBySearchTerm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchTerm', Sort.asc);
    });
  }

  QueryBuilder<Cache, Cache, QAfterSortBy> sortBySearchTermDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchTerm', Sort.desc);
    });
  }
}

extension CacheQuerySortThenBy on QueryBuilder<Cache, Cache, QSortThenBy> {
  QueryBuilder<Cache, Cache, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Cache, Cache, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Cache, Cache, QAfterSortBy> thenBySearchTerm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchTerm', Sort.asc);
    });
  }

  QueryBuilder<Cache, Cache, QAfterSortBy> thenBySearchTermDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchTerm', Sort.desc);
    });
  }
}

extension CacheQueryWhereDistinct on QueryBuilder<Cache, Cache, QDistinct> {
  QueryBuilder<Cache, Cache, QDistinct> distinctBySearchTerm(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'searchTerm', caseSensitive: caseSensitive);
    });
  }
}

extension CacheQueryProperty on QueryBuilder<Cache, Cache, QQueryProperty> {
  QueryBuilder<Cache, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Cache, List<Food>?, QQueryOperations> foodsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'foods');
    });
  }

  QueryBuilder<Cache, String?, QQueryOperations> searchTermProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'searchTerm');
    });
  }
}
