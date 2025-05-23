
import 'package:isar/isar.dart';

part 'food_model.g.dart';

@embedded
class Food {
  String? name;
  String? fat, carbs, protein;
  String? thumbUrl;

  Food();

  // Food.fromJson(Map<String, dynamic> json)
  //     : name = json['product_name'];

}