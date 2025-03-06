


import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:meseros_app/shared_preferences/preference.dart';

class MainProvider extends ChangeNotifier{
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  String username = "";
  String password = "";
  bool _isLoading = false;
  String backend = '${Preferences.ipServer}:${Preferences.port}';
  List<String> meseros = [];
  int _currentOptNav = 0;
  MainProvider(){
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

    getMeseros() async{
    final url = Uri.http(backend, 'meseros/get-meseros');
    try{
    final response = await http.get(url);
      // print(jsonDecode(response.body));
      final data = await jsonDecode(response.body);
      meseros = data.map<String>((e)=>e['name'].toString()).toList();
      // print(data);
      notifyListeners();
    }catch(e){
      print(e);
    }
  }

  Future<bool> validateUser(String user, String passwd) async {
    final url = Uri.http(backend, 'meseros/validate-mesero',{'name': user, 'password':passwd});
    print(url);
    // final Map<String, String> data = {'usuario': user, 'password': passwd};
    try {
      final response = await http.post(url);
      if (response.statusCode != 200) {
        return false;
      }
      return true;
    } catch (error) {
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

}