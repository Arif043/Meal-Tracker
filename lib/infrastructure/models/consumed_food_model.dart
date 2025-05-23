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

  double get fat => _toDouble(food!.fat!);
  double get carbs => _toDouble(food!.carbs!);
  double get protein => _toDouble(food!.protein!);

  double _toDouble(String? rawVal) {
    final String val = rawVal ?? '';
    if (val.isNotEmpty && double.tryParse(val) != null) {
      return double.parse(val) * amount!;
    }
    return 0;
  }

  // ConsumedFood.fromJson(Map<String, dynamic> json)
  //   : amount = json['amount'] as double,
  //     timestamp = DateTime.now(),
  //     food = Food.fromJson(json);
}
