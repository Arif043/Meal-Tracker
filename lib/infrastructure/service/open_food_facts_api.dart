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
    'User-Agent': '$APP_NAME/0.1.0 (arif.ertugrul@outlook.de)',
    'Authorization': 'Basic ${base64Encode(utf8.encode('off:off'))}',
  };

  OpenFoodFactsApi._();

  factory OpenFoodFactsApi() => _instance;

  Future<List<Food>> search(String searchTerm) async {
    //https://de.openfoodfacts.org/cgi/search.pl?search_terms=eier&search_simple=1&action=process&json=1
    log('HTTP Request started', name: 'fitness');

    final res = await http.get(
      Uri.https('de.openfoodfacts.org', '/cgi/search.pl', {
        'search_terms': searchTerm,
        'search_simple': '1',
        'action': "process",
        'json': '1'
      }),
      //headers: header,
    );


    final parsedBody = jsonDecode(res.body);

    if (res.statusCode != 200) throw ServerException();
    log(res.statusCode.toString(), name: 'fitness');

    final products = <Food>[];
    for (dynamic product in parsedBody['products']) {
      log(product['product_name'] as String, name: 'fitness');
      log(product['selected_images']['thumb']['de'] as String, name: 'fitness');
      final food = Food();
      final thumbUrl = product['selected_images']['thumb']['de'] as String;


      food.name = product['product_name'] as String;
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
    debugPrint(uuid);
  }
}
