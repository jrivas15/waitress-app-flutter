import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meseros_app/providers/main_provider.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);

    return BottomNavigationBar(
      backgroundColor: const Color.fromRGBO(25, 25, 25, 1),
      currentIndex: mainProvider.currentOptNav,
      onTap: (int index) {
        mainProvider.currentOptNav = index;
      },
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
        const BottomNavigationBarItem(
            icon: Icon(Icons.table_restaurant_rounded), label: '')
        
      ],
      selectedItemColor: const Color.fromRGBO(214, 48, 49, 1),
      unselectedItemColor: Colors.white,
    );
  }
}