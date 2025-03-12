import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meseros_app/models/category_model.dart';
import 'package:meseros_app/models/product_model.dart';
import 'package:meseros_app/shared_preferences/preference.dart';

class ProductProvider extends ChangeNotifier {
  String backend = '${Preferences.ipServer}:${Preferences.port}';
  List<CategoryModel> categories = [];
  CategoryModel? _selectedCategory;
  List<ProductModel> products = [];
  CategoryModel? get selectedCategory => _selectedCategory;
  ProductModel? currentProduct;
  set selectedCategory(CategoryModel? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  getCategories() async {
    Uri url = Uri.http(backend, 'products/get-categories');
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        categories = [];
      } else {
        categories = categoryModelFromJson(response.body);
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
  //*-------- PRODUCTS ----------

  getProductByCategory(CategoryModel category) async {
    Uri url = Uri.http(backend, 'products/get-products-by-category', {
      'category': category.id.toString(),
    });
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        products = [];
      } else {
        products = productModelFromJson(response.body);
        // print(products);
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
} //----
