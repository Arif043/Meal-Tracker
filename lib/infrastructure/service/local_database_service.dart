import 'dart:io';

import 'package:fitness_tracker/infrastructure/models/cache.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/consumed_food_model.dart';
import '../models/food_model.dart';

class LocalDatabaseService {
  static final _instance = LocalDatabaseService._();
  late final Isar _isar;

  LocalDatabaseService._() {
    _init();
  }

  factory LocalDatabaseService() => _instance;

  void _init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([
      ConsumedFoodSchema,
      CacheSchema,
    ], directory: dir.path);
  }

  Future<List<ConsumedFood>> loadConsumedFoods(DateTime? selectedDay) async {
    selectedDay ??= DateTime.now();
    final from = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
    final to = from.copyWith(hour: 23, minute: 59, second: 59);
    return await _isar.consumedFoods
        .where()
        .timestampBetween(from, to)
        .findAll();
  }

  void saveConsumedFood(ConsumedFood food) async {
    await _isar.writeTxn(() async {
      await _isar.consumedFoods.put(food);
    });
  }

  Future<bool> existsCachedFood(String searchTerm) async =>
      await _isar.caches.where().searchTermEqualTo(searchTerm).findFirst() !=
      null;

  Future<List<Food>> loadFoods(String searchTerm) async =>
      (await _isar.caches.where().searchTermEqualTo(searchTerm).findFirst())!
          .foods!;

  void cacheFoods(String searchTerm, List<Food> foods) async {
    final cache =
        Cache()
          ..searchTerm = searchTerm
          ..foods = foods;

    _isar.writeTxn(() => _isar.caches.put(cache));
  }

  void close() {
    _isar.close();
  }
}
