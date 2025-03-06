import 'package:flutter/material.dart';
import 'package:meseros_app/models/table_model.dart';
import 'package:meseros_app/shared_preferences/preference.dart';

class TableProvider extends ChangeNotifier{
String backend = '${Preferences.ipServer}:${Preferences.port}/mesas';
List<TableModel> tables = [];
String _selectedZone = 'Todas';

String get selectedZone => _selectedZone;

set selectedZone(String zone){
  _selectedZone = zone;
  notifyListeners();
}

  
}