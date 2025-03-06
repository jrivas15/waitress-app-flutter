import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _preferences;

  static String _ipServer = '';
  static String _port = '';
  // static String _user = '';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static String get ipServer => _preferences.getString('ipServer') ?? _ipServer;

  static set ipServer(String ipServer) {
    _ipServer = ipServer;
    _preferences.setString('ipServer', ipServer);
  }

  static String get port => _preferences.getString('port') ?? _port;

  static set port(String port) {
    _port = port;
    _preferences.setString('port', port);
  }
}