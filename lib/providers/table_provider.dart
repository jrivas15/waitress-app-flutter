import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:meseros_app/models/table_model.dart';
import 'package:meseros_app/models/zone_model.dart';
import 'package:meseros_app/shared_preferences/preference.dart';
import 'package:http/http.dart' as http;

class TableProvider extends ChangeNotifier {
  String backend = '${Preferences.ipServer}:${Preferences.port}';
  List<TableModel> tables = [];
  ZonesModel _selectedZone = ZonesModel(id: 0, name: 'Todas');
  List<ZonesModel> zones = [];
  int _currentOptNav = 0;
  Logger logger = Logger();
  int? _gruopOptionsRadioStateProducts = 1;

  //*------- NAV BAR ---------
  int get currentOptNav => _currentOptNav;

  set currentOptNav(int currentIndex) {
    _currentOptNav = currentIndex;
    notifyListeners();
  }

  //*------- radio options table ---------
  int? get gruopOptionsRadioStateProducts => _gruopOptionsRadioStateProducts;
  set gruopOptionsRadioStateProducts(int? currentOption) {
    _gruopOptionsRadioStateProducts = currentOption;
    notifyListeners();
  }
  //*------- Zones ---------

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
      logger.e(error);
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
      logger.e(error);
    }
  }

  resetTables() {
    logger.d('RESETTING TABLES');
    selectedZone.id = 0;
    tables = [];
    notifyListeners();
  }
}
