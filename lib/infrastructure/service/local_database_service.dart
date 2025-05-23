import 'dart:io';

import 'package:meal_tracker/infrastructure/models/cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/consumed_food_model.dart';
import '../models/food_model.dart';

class LocalDatabaseService {
  late final Isar _isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([
      ConsumedFoodSchema,
      CacheSchema,
    ], directory: dir.path);
  }

  Future<List<ConsumedFood>> loadConsumedFoods(DateTime selectedDay) async {
    debugPrint(selectedDay.toString());
    final from = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
    final to = from.copyWith(hour: 23, minute: 59, second: 59);
    return await _isar.consumedFoods
        .where()
        .timestampBetween(from, to)
        .findAll();
  }

  Future<List<ConsumedFood>> saveConsumedFood(Food food, double amount) async {
    final consumed = ConsumedFood()
    ..food = food
    ..amount = amount
    ..timestamp = DateTime.now();
    await _isar.writeTxn(() async {
      await _isar.consumedFoods.put(consumed);
    });
    return loadConsumedFoods(DateTime.now());
  }

  Future<bool> existsCachedFood(String searchTerm) async =>
      await _isar.caches.where().searchTermEqualTo(searchTerm).findFirst() !=
      null;

  Future<List<Food>> loadFoods(String searchTerm) async =>
      (await _isar.caches.where().searchTermEqualTo(searchTerm).findFirst())!
          .foods!;

  Future<void> removeConsumedFood(ConsumedFood food) async {
    await _isar.writeTxn(() async {
      await _isar.consumedFoods.delete(food.id);
    },);
  }

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
