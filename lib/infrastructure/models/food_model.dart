import 'package:isar/isar.dart';

@collection
class Food {
  Id id = Isar.autoIncrement;

  String? name;
  double? fat, carbs, protein;

  Food.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      fat = json['fat'];

  //double get calorien => fat * 9 + carbs * 4 + protein * 4;
}
