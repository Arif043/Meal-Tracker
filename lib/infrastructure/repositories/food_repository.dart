import 'dart:io';

import 'package:fitness_tracker/infrastructure/exceptions/exceptions.dart';
import 'package:fitness_tracker/infrastructure/models/consumed_food_model.dart';
import 'package:fitness_tracker/infrastructure/service/local_database_service.dart';
import 'package:fitness_tracker/infrastructure/service/open_food_facts_api.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:path_provider/path_provider.dart';
import '../../domain/failures/failures.dart';
import '../models/food_model.dart';

class FoodRepository {

  static final _instance = FoodRepository._();
  final _openFoodApi = OpenFoodFactsApi();
  final _dbService = LocalDatabaseService();

  FoodRepository._();
  factory FoodRepository() => _instance;

  Future<Result<List<Food>, Failure>> search(String term) async {
    if (await _dbService.existsCachedFood(term)) {
      return Success(await _dbService.loadFood(term));
    }

    try {
      final foods = await _openFoodApi.search(term);
      _dbService.cacheFoods(term, foods);
      return Success(foods);

    } on ProductsNotFoundException {
      return Error(ProductFailure());
    } catch (e) {
      return Error(GeneralFailure());
    }
  }

  double getMakro(Product products, Nutrient nutrient) => products.nutriments?.getValue(nutrient, PerSize.oneHundredGrams) ?? 0;

  Future<List<ConsumedFood>> loadConsumedFoods(DateTime? selectedDay) => _dbService.loadConsumedFoods(selectedDay);

  void saveConsumedFood(ConsumedFood food) => _dbService.saveConsumedFood(food);

  void close() {
    _dbService.close();
  }
}