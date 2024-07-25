import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myshop/service/api/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final ProductApi productApi = ProductApi();
    bool isLoading = false;

  List<Products> products = [];
  Future<void> fetchProduct() async {
    isLoading = true;
    notifyListeners();
    try {
      final fetchedProducts = await productApi.fetchProducts();
      if (fetchedProducts != null) {
        products = fetchedProducts;
      }
    } catch (e) {
      log('Error fetching producs: $e ');
    }finally {
    isLoading = false;
    notifyListeners();
  }
  }

  // final List<ProductModel> favoriteProduct = productlist;
  // List<ProductModel> get productList => favoriteProduct;
  // void toogleFavorite(ProductModel product) {
  //   if(product.isFavorite) {
  //     favoriteProduct.remove(product);
  //     product.isFavorite = false;
  //   } else {
  //     favoriteProduct.add(product);
  //     product.isFavorite = true;
  //   }
  //   notifyListeners();
  // }
}
