import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:meseros_app/models/category_model.dart';
import 'package:meseros_app/models/modifier_model.dart';
import 'package:meseros_app/models/product_model.dart';
import 'package:meseros_app/shared_preferences/preference.dart';

class ProductProvider extends ChangeNotifier {
  String backend = '${Preferences.ipServer}:${Preferences.port}';
  List<CategoryModel> categories = [];
  CategoryModel? _selectedCategory;
  List<ProductModel> products = [];
  CategoryModel? get selectedCategory => _selectedCategory;
  ProductModel? currentProduct;
  //*Modifiers
  List<ModifierModel> listModifiers = [];
  List<ModifierModel> currModifiers = [];
  //*note
  String currNote = "";

  Logger logger = Logger();
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
      logger.e(error);
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
      logger.e(error);
    }
  }

  //*-----Modifiers---
  resetProductDetails() {
    listModifiers = [];
    currModifiers = [];
    currNote = "";
    notifyListeners();
  }

  addModifiersChecks(bool state, ModifierModel modifier) {
    if (currModifiers.contains(modifier) && state == false) {
      currModifiers.removeWhere((item) => item.id == modifier.id);
    } else {
      currModifiers.add(modifier);
    }
    notifyListeners();
  }

  Future<void> getModifiers(int productID) async {
    Uri url = Uri.http(backend, 'products/get-modifiers', {
      'productID': productID.toString(),
    });
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        listModifiers = [];
      } else {
        listModifiers = modifierModelFromJson(response.body);
        // print(products);
      }
      notifyListeners();
    } catch (error) {
      logger.e(error);
    }
  }
} //----
