import 'dart:async';
import 'dart:io';
import 'package:fitness_tracker/domain/repositories/food_repository.dart';
import 'package:fitness_tracker/infrastructure/exceptions/exceptions.dart';
import 'package:fitness_tracker/infrastructure/models/consumed_food_model.dart';
import 'package:fitness_tracker/infrastructure/service/local_database_service.dart';
import 'package:fitness_tracker/infrastructure/service/open_food_facts_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:path_provider/path_provider.dart';
import '../../domain/failures/failures.dart';
import '../models/food_model.dart';

class FoodRepositoryImpl implements FoodRepository {
  static final _instance = FoodRepositoryImpl._();
  final _openFoodApi = OpenFoodFactsApi();
  final _dbService = LocalDatabaseService();

  FoodRepositoryImpl._();
  factory FoodRepositoryImpl() => _instance;

  @override
  Future<Result<List<Food>, Failure>> searchRemote(String term) async {
    try {
      final foods = await _openFoodApi.search(term);
      if (foods.isNotEmpty) {
        _dbService.cacheFoods(term, foods);
      }
      return Success(foods);
    } on ProductsNotFoundException {
      return Error(ProductFailure());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      return Error(GeneralFailure());
    }
  }

  @override
  Future<List<Food>> searchInCache(String searchTerm) async {
    if (await _dbService.existsCachedFood(searchTerm)) {
      return await _dbService.loadFoods(searchTerm);
    }
    return const [];
  }

  @override
  double getMakro(Product products, Nutrient nutrient) =>
      products.nutriments?.getValue(nutrient, PerSize.oneHundredGrams) ?? 0;

  @override
  Future<List<ConsumedFood>> loadConsumedFoods(DateTime? selectedDay) =>
      _dbService.loadConsumedFoods(selectedDay);

  @override
  void saveConsumedFood(ConsumedFood food) => _dbService.saveConsumedFood(food);

  @override
  void close() {
    _dbService.close();
  }
}
