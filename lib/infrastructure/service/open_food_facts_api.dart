import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fitness_tracker/infrastructure/exceptions/exceptions.dart';
import 'package:fitness_tracker/infrastructure/models/consumed_food_model.dart';
import 'package:fitness_tracker/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/v4.dart';

import '../models/food_model.dart';

class OpenFoodFactsApi {
  static final _instance = OpenFoodFactsApi._();
  static final header = {
    'User-Agent': 'App3432 - Android - Version 0.1',
  };

  OpenFoodFactsApi._();

  factory OpenFoodFactsApi() => _instance;

  Future<List<Food>> search(String searchTerm) async {
    final res = await http.get(
      Uri.https('de.openfoodfacts.org', '/cgi/search.pl', {
        'search_terms': searchTerm,
        'search_simple': '1',
        'action': "process",
        'fields': 'product_name,selected_images,nutriments',
        'page_size': '5',
        'json': '1'
      }),
      headers: header,
    );
    debugPrint(res.body);
    final Map<String, dynamic> parsedBody = jsonDecode(res.body);
    // debugPrint(parsedBody.toString());

    if (res.statusCode != 200) throw ServerException();

    final products = <Food>[];
    for (dynamic product in parsedBody['products']) {
      final food = Food();
      final name = product['product_name'] as String;
      final thumbUrl = product['selected_images']['front']['thumb']['de'] as String;
      final fat = double.parse(product['nutriments']['fat_100g'].toString());
      debugPrint(fat.toString());
      final carbs = double.parse(product['nutriments']['carbohydrates_100g'].toString());
      debugPrint(carbs.toString());
      final protein = double.parse(product['nutriments']['proteins_100g'].toString());
      debugPrint(protein.toString());
      food.name = product['product_name'] as String;
      food.fat = fat;
      food.carbs= carbs;
      food.protein = protein;
      food.thumbUrl = thumbUrl;
      products.add(food);
    }
    return products;
  }

  void _setUuid() async {
    final secureStorage = FlutterSecureStorage();
    var uuid = await secureStorage.read(key: 'uuid');
    if (uuid == null) {
      uuid = UuidV4().generate();
      secureStorage.write(key: 'uuid', value: uuid);
    }
    OpenFoodAPIConfiguration.uuid = uuid;
  }
}
