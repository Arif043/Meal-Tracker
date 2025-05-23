import 'package:shared_preferences/shared_preferences.dart';

class SpService {

  Future<void> saveTarget(int fat, int carbs, int protein) async {
    final sp = await SharedPreferences.getInstance();
    sp.setInt('fat', fat);
    sp.setInt('carbs', carbs);
    sp.setInt('protein', protein);
  }

  Future<({int fat, int carbs, int protein})> loadTarget() async {
    final sp = await SharedPreferences.getInstance();
    final (fat, carbs, protein) = (sp.getInt('fat') ?? 0, sp.getInt('carbs') ?? 0, sp.getInt('protein') ?? 0);
    return (fat: fat, carbs: carbs, protein: protein);
  }
}