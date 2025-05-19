
import 'package:isar/isar.dart';
import 'food_model.dart';

part 'cache.g.dart';

@collection
class Cache {
  Id id = Isar.autoIncrement;
  @Index()
  String? searchTerm;
  // final food = IsarLink<Food>();
  List<Food>? foods;

  Cache();
}