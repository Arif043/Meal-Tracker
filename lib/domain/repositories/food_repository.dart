import 'package:multiple_result/multiple_result.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import '../../infrastructure/models/consumed_food_model.dart';
import '../../infrastructure/models/food_model.dart';
import '../failures/failures.dart';

abstract class FoodRepository {

  Future<Result<List<Food>, Failure>> searchRemote(String term);
  Future<List<Food>> searchInCache(String searchTerm);
  double getMakro(Product products, Nutrient nutrient);
  Future<List<ConsumedFood>> loadConsumedFoods(DateTime? selectedDay);
  void saveConsumedFood(ConsumedFood food);

  void close();
}