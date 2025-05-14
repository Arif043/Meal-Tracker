import 'package:isar/isar.dart';

part 'consumed_food_model.g.dart';
@collection
class ConsumedFood {
  Id id = Isar.autoIncrement;

  String? name;
  double? fat, carbs, protein;
  @Index()
  DateTime? timestamp;

  ConsumedFood();

  ConsumedFood.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      fat = json['fat'];

  //double get calorien => fat * 9 + carbs * 4 + protein * 4;
}
