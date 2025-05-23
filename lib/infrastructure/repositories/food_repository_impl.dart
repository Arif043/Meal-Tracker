import 'dart:async';
import 'dart:io';
import 'package:fitness_tracker/domain/repositories/food_repository.dart';
import 'package:fitness_tracker/infrastructure/exceptions/exceptions.dart';
import 'package:fitness_tracker/infrastructure/models/consumed_food_model.dart';
import 'package:fitness_tracker/infrastructure/service/local_database_service.dart';
import 'package:fitness_tracker/infrastructure/service/open_food_facts_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:path_provider/path_provider.dart';
import '../../domain/failures/failures.dart';
import '../models/food_model.dart';

class FoodRepositoryImpl implements FoodRepository {
  final OpenFoodFactsApi _openFoodApi;
  final LocalDatabaseService _dbService;

  int _pageNumber = 1;
  int get pageNumber => _pageNumber;

  FoodRepositoryImpl(this._openFoodApi, this._dbService);

  @override
  Future<Result<List<Food>, Failure>> searchRemote(String term) async {
    try {
      final foods = await _openFoodApi.search(term, _pageNumber);
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

  Future<Result<List<Food>, Failure>> showPreviousPage(String term) async {
    // if (_pageNumber == 0)
    //   return;

    _pageNumber--;
    return searchRemote(term);
  }

  Future<Result<List<Food>, Failure>> showNextPage(String term) async {
    _pageNumber++;
    return searchRemote(term);
  }

  @override
  Future<void> removeConsumedFood(ConsumedFood food) => _dbService.removeConsumedFood(food);

  // @override
  // double getMakro(Product products, Nutrient nutrient) =>
  //     products.nutriments?.getValue(nutrient, PerSize.oneHundredGrams) ?? 0;

  @override
  Future<List<ConsumedFood>> loadConsumedFoods(DateTime selectedDay) =>
      _dbService.loadConsumedFoods(selectedDay);

  @override
  Future<List<ConsumedFood>> saveConsumedFood(Food food, double amount) => _dbService.saveConsumedFood(food, amount);

  @override
  void close() {
    _dbService.close();
  }
}
