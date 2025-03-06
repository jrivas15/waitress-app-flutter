import 'package:flutter/material.dart';
import 'package:meseros_app/models/table_model.dart';
import 'package:meseros_app/models/zone_model.dart';
import 'package:meseros_app/shared_preferences/preference.dart';
import 'package:http/http.dart' as http;

class TableProvider extends ChangeNotifier {
  String backend = '${Preferences.ipServer}:${Preferences.port}';
  List<TableModel> tables = [];
  ZonesModel _selectedZone = ZonesModel(id: 0, name: 'Todas');
  List<ZonesModel> zones = [];

  ZonesModel get selectedZone => _selectedZone;

  set selectedZone(ZonesModel zone) {
    _selectedZone = zone;
    notifyListeners();
  }

  getTablesByZone(int idZone) async {
    Uri url = Uri.http(backend, 'tables/get');
    if (idZone != 0) {
      url = Uri.http(backend, 'tables/get-by-id-zone', {'idZone': '$idZone'});
    }
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        tables = [];
      } else {
        tables = tableModelFromJson(response.body);
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  getZones() async {
    Uri url = Uri.http(backend, 'tables/get-zones');
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        zones = [];
      } else {
        zones = zonesModelFromJson(response.body);
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
