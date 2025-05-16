import 'package:isar/isar.dart';
import 'food_model.dart';

part 'consumed_food_model.g.dart';

@collection
class ConsumedFood {
  Id id = Isar.autoIncrement;
  Food? food;
  double? amount;
  @Index()
  DateTime? timestamp;

  ConsumedFood();

  String get name => food!.name!;

  ConsumedFood.fromJson(Map<String, dynamic> json)
    : amount = json['amount'] as double,
      timestamp = DateTime.now(),
      food = Food.fromJson(json);
}
