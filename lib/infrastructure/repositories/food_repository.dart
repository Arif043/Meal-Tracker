import 'package:fitness_tracker/infrastructure/models/consumed_food_model.dart';
import 'package:fitness_tracker/infrastructure/service/local_database_service.dart';
import 'package:fitness_tracker/infrastructure/service/open_food_facts_api.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class FoodRepository {

  final _openFoodApi = OpenFoodFactsApi();
  final _dbService = LocalDatabaseService();

  Future<List<Product>> search(String term) {
    return _openFoodApi.search(term);
  }

  double getMakro(Product products, Nutrient nutrient) => products.nutriments?.getValue(nutrient, PerSize.oneHundredGrams) ?? 0;

  Future<List<ConsumedFood>> loadConsumedFoods(DateTime? selectedDay) => _dbService.loadConsumedFoods(selectedDay);

  void saveConsumedFood(ConsumedFood food) => _dbService.saveConsumedFood(food);

  void close() {
    _dbService.close();
  }
}