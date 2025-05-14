import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/consumed_food_model.dart';

class LocalDatabaseService {

  static final _instance = LocalDatabaseService._();

  late final Isar _isar;

  LocalDatabaseService._(){
    _initIsar();
  }

  factory LocalDatabaseService() => _instance;

  void _initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([ConsumedFoodSchema], directory: (await getApplicationDocumentsDirectory()).path);
  }

  Future<List<ConsumedFood>> loadConsumedFoods(DateTime? selectedDay) async {
    selectedDay ??= DateTime.now();
    final from = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
    final to = from.copyWith(hour: 23, minute: 59, second: 59);
    return await _isar.consumedFoods.where().timestampBetween(from, to).findAll();
  }

  void saveConsumedFood(ConsumedFood food) async {
    await _isar.writeTxn(() async {
      await _isar.consumedFoods.put(food);
    });
  }

  void close() {
    _isar.close();
  }
}