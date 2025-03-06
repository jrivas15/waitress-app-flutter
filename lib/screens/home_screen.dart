import 'package:flutter/material.dart';
import 'package:meseros_app/screens/tables_screen.dart';
import 'package:meseros_app/widgets/custom_bottom_nav.dart';
import 'package:provider/provider.dart';
import 'package:meseros_app/providers/main_provider.dart';
import 'package:meseros_app/screens/stast_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _SwitchScreen(),
      bottomNavigationBar: CustomBottomNav(),
    );
  }
}


class _SwitchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    // final dataProvider = Provider.of<DataProvider>(context, listen: false);
    final currentIndex = mainProvider.currentOptNav;
    switch (currentIndex) {
      case 0:
        // dataProvider.getBalanceVentas();
        // dataProvider.get10Sells();
        // dataProvider.getPaymentStats();
        // dataProvider.getInfoGeneral();
        return StatsScreen();
      case 1:
        // dataProvider.getCategories();
        return const TablesScreen();
      default:
        return const StatsScreen();
    }
  }
}