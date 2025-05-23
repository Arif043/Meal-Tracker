import 'package:multiple_result/multiple_result.dart';
import '../../infrastructure/models/consumed_food_model.dart';
import '../../infrastructure/models/food_model.dart';
import '../failures/failures.dart';

abstract class FoodRepository {

  Future<Result<List<Food>, Failure>> searchRemote(String term);
  Future<List<Food>> searchInCache(String searchTerm);
  // double getMakro(Product products, Nutrient nutrient);
  Future<List<ConsumedFood>> loadConsumedFoods(DateTime selectedDay);
  Future<List<ConsumedFood>> saveConsumedFood(Food food, double amount);
  Future<Result<List<Food>, Failure>> showPreviousPage(String term);
  Future<Result<List<Food>, Failure>> showNextPage(String term);
  Future<void> removeConsumedFood(ConsumedFood food);
  int get pageNumber;
  void close();
}