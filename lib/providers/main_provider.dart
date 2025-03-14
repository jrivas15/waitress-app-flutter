import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:meseros_app/models/stasts_models.dart';
import 'package:meseros_app/models/waitress_model.dart';
import 'package:meseros_app/shared_preferences/preference.dart';

class MainProvider extends ChangeNotifier {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  String username = "";
  String password = "";
  bool _isLoading = false;
  String backend = '${Preferences.ipServer}:${Preferences.port}';
  List<String> waitresses = [];
  int _currentOptNav = 0;
  WaitressModel? waitress;
  Logger logger = Logger();
  List<StatsModel> stats = [];
  MainProvider() {
    getMeseros();
  }
  //*------- NAV BAR ---------
  int get currentOptNav {
    return _currentOptNav;
  }

  set currentOptNav(int currentIndex) {
    _currentOptNav = currentIndex;
    notifyListeners();
  }

  getMeseros() async {
    final url = Uri.http(backend, 'tables/get-waitresses');
    try {
      final response = await http.get(url);
      // print(jsonDecode(response.body));
      final data = await jsonDecode(response.body);
      waitresses =
          data.map<String>((waitress) => waitress['name'].toString()).toList();
      // print(data);
      notifyListeners();
    } catch (e) {
      logger.e(e);
    }
  }

  Future<bool> validateUser(String user, String? passwd) async {
    final url = Uri.http(backend, 'tables/validate-waitress', {
      'name': user,
      'password': passwd ?? '',
    });

    // final Map<String, String> data = {'usuario': user, 'password': passwd};
    try {
      final response = await http.post(url);
      if (response.statusCode != 200) {
        return false;
      }
      waitress = waitressModelFromJson(response.body);
      return true;
    } catch (error) {
      logger.e(error);
      return false;
    }
  }

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    // print(formKey.currentState?.validate());

    return loginKey.currentState?.validate() ?? false;
  }

  getStats() async {
    final url = Uri.http(backend, 'tables/stats');
    try {
      final response = await http.get(url);
      stats = statsModelFromJson(response.body);
      notifyListeners();
    } catch (e) {
      logger.e(e);
    }
  }
}
