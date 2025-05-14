import 'package:fitness_tracker/infrastructure/exceptions/exceptions.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class OpenFoodFactsApi {

  static final _instance = OpenFoodFactsApi._();

  OpenFoodFactsApi._();

  factory OpenFoodFactsApi() => _instance;

  Future<List<Product>> search(String term) async {
    final terms = SearchTerms(terms: []);
    final conf = ProductSearchQueryConfiguration(parametersList: [terms, SortBy(option: SortOption.POPULARITY)], version: ProductQueryVersion.v3);

    final result = await OpenFoodAPIClient.searchProducts(User(userId: '', password: ''), conf);
    debugPrint(result.products.toString());

    if (result.products == null)
      throw ProductsNotFoundException();

    return result.products!;
  }

}