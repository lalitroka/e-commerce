import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:myshop/service/api/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final ProductApi productApi = ProductApi();
  List<Products> products = [];
  bool isLoading = false;

  ProductProvider() {
    fetchingProduct();
  }

  Future<void> fetchingProduct() async {
    isLoading = true;
    notifyListeners();
    try {
      final fetchedProducts = await productApi.fetchProducts();
      if (fetchedProducts != null) {
        products = fetchedProducts;
        log('Fetched products: ${products.map((a) => a.title).toList()}');
      }
    } catch (e) {
      log('Error fetching products: $e', error: e);
    } finally {
      // log('fetch is sucessfull');
      isLoading = false;
      notifyListeners();
    }
  }
}
