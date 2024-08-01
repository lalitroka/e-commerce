import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:myshop/model/product_fav_model.dart';
import 'package:myshop/model/user_data.dart';
import 'package:myshop/service/api/product_model.dart';
import 'package:myshop/service/database_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductApi productApi = ProductApi();
  List<Products> products = [];
  bool isLoading = false;

  ProductProvider() {
    fetchingProduct();
    notifyListeners();
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
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteStatusfunction(ProductFavModel product) async {
    await DatabaseService().toggleFavoriteStatus(product);
    notifyListeners();
  }

  Future<bool> isProductFavorite(int id) async {
    return await DatabaseService().isProductSaved(id);
  }


//  for users data

 User? _user;

  User? get user => _user;

  Future<void> fetchUserData() async {
    await Future.delayed(const Duration(seconds: 1));
    notifyListeners();
  }

  void updateUserData({
    required String username,
    required String age,
    required String country,
    required String phone,
    required String email,
    required String gender,
  }) {
    _user = User(
      username: username,
      age: age,
      country: country,
      phone: phone,
      email: email,
      gender: gender,
    );
    notifyListeners();
  }
  
  }

