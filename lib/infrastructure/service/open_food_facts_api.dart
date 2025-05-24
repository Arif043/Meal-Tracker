import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:meal_tracker/infrastructure/exceptions/exceptions.dart';
import 'package:meal_tracker/infrastructure/models/consumed_food_model.dart';
import 'package:meal_tracker/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/v4.dart';
import '../models/food_model.dart';

class OpenFoodFactsApi {

  static final header = {
    'User-Agent': 'Meal Tracker/1.0 (arif.ertugrul@outlook.com)',
  };

  Future<List<Food>> search(String searchTerm, int pageNumber) async {
    final res = await http.get(
      Uri.https('de.openfoodfacts.org', '/cgi/search.pl', {
        'search_terms': searchTerm,
        'search_simple': '1',
        'action': "process",
        'fields': 'product_name,selected_images,nutriments',
        'page_size': '50',
        'page': '$pageNumber',
        'json': '1'
      }),
      //headers: header,
    );
    late final Map<String, dynamic> parsedBody;
    try {
      parsedBody = jsonDecode(res.body);
    } on FormatException {
      throw ServerException();
    }
    if (res.statusCode != 200) throw ServerException();

    final products = <Food>[];
    for (dynamic product in parsedBody['products']) {
      final food = Food();
      final name = product?['product_name'] as String? ?? '';
      final thumbUrl = product?['selected_images']?['front']?['thumb']?['de'] as String? ?? '';
      final fat = product?['nutriments']?['fat_100g'] as Object? ?? '';
      final carbs = product?['nutriments']?['carbohydrates_100g'] as Object? ?? '';
      final protein = product?['nutriments']?['proteins_100g'] as Object? ?? '';
      food.name = product?['product_name'] as String? ?? '';
      food.fat = fat.toString();
      food.carbs = carbs.toString();
      food.protein = protein.toString();
      food.thumbUrl = thumbUrl;
      products.add(food);
    }

    if (products.isEmpty)
      throw ProductsNotFoundException();

    return products;
  }
}