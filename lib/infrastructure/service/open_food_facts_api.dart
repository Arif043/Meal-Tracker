import 'package:http/http.dart';

class OpenFoodFactsApi {

  static late final _instance = OpenFoodFactsApi._();

  OpenFoodFactsApi._();

  factory OpenFoodFactsApi() => _instance;

  void search(String term) {
    //get(url)
  }
}