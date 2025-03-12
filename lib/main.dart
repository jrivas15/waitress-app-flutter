import 'package:flutter/material.dart';
import 'package:meseros_app/providers/main_provider.dart';
import 'package:meseros_app/providers/order_provider.dart';
import 'package:meseros_app/providers/product_provider.dart';
import 'package:meseros_app/providers/table_provider.dart';
import 'package:meseros_app/screens/home_screen.dart';
import 'package:meseros_app/screens/login_screen.dart';
import 'package:meseros_app/screens/preferences_screen.dart';
import 'package:meseros_app/screens/table_details.dart';
import 'package:meseros_app/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:meseros_app/shared_preferences/preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => TableProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
          lazy: true,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meseros App',
      initialRoute: 'login',
      theme: AppTheme.theme,
      routes: {
        'login': (_) => LoginScreen(),
        'preferences': (_) => SettingsScreen(),
        '/': (_) => HomeScreen(),
        'table-details': (_) => TableDetails(),
      },
    );
  }
}
