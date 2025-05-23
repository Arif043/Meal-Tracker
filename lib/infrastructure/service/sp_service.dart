import 'package:shared_preferences/shared_preferences.dart';

class SpService {

  Future<void> saveTarget(double fat, double carbs, double protein) async {
    final sp = await SharedPreferences.getInstance();
    sp.setDouble('fat', fat);
    sp.setDouble('carbs', carbs);
    sp.setDouble('protein', protein);
  }

  Future<({double fat, double carbs, double protein})> loadTarget() async {
    final sp = await SharedPreferences.getInstance();
    final (fat, carbs, protein) = (sp.getDouble('fat') ?? 0, sp.getDouble('carbs') ?? 0, sp.getDouble('protein') ?? 0);
    return (fat: fat, carbs: carbs, protein: protein);
  }
}