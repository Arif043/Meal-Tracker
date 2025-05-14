import 'dart:convert';

import 'package:fitness_tracker/infrastructure/exceptions/exceptions.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

class OpenFoodFactsApi {

  static final _instance = OpenFoodFactsApi._();

  OpenFoodFactsApi._();

  factory OpenFoodFactsApi() => _instance;

  Future<List<Product>> search(String term) async {
    final terms = SearchTerms(terms: []);
    final conf = ProductSearchQueryConfiguration(parametersList: [terms, SortBy(option: SortOption.POPULARITY)], version: ProductQueryVersion.v3);

    final result = OpenFoodAPIClient.getSuggestions(, language: language)
    final result = await OpenFoodAPIClient.searchProducts(User(userId: '', password: ''), conf);
    debugPrint(result.products.toString());

    if (result.products == null)
      throw ProductsNotFoundException();

    return result.products!;
  }

  void _getUuid() async {
    final secureStorage = FlutterSecureStorage();
    var uuid = await secureStorage.read(key: 'uuid');
    if (uuid == null) {
      final rawUuid = UuidV4().generate();
      uuid = sha256.convert(utf8.encode(rawUuid)).toString();

      secureStorage.write(key: 'uuid', value: uuid);
    }
    debugPrint(uuid);
  }
}