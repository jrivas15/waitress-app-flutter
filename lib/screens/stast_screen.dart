import 'package:flutter/material.dart';
import 'package:meseros_app/providers/providers.dart';
import 'package:meseros_app/theme/app_theme.dart';
import 'package:meseros_app/widgets/home_background.dart';
import 'package:provider/provider.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      {"name": "Mesas", "value": "99"},
      {"name": "Disponibles", "value": "50"},
      {"name": "Ocupadas", "value": "49"},
      {"name": "A foro", "value": "95%"},
      {"name": "Ocupadas", "value": "49"},
      {"name": "Ocupadas", "value": "49"},
    ];
    final mainProvider = Provider.of<MainProvider>(context);
    final stats = mainProvider.stats;
    return Scaffold(
      body: HomeBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _CardUser(),
                Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children:
                      stats
                          .map(
                            (stat) =>
                                _SimpleStat(name: stat.name, value: stat.value),
                          )
                          .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SimpleStat extends StatelessWidget {
  final String name;
  final dynamic value;
  const _SimpleStat({super.key, required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: AppTheme.simpleCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(name, style: TextStyle(fontSize: 20)),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              // color: Colors.amberAccent,
              child: Center(
                child: Text(
                  '${value}',
                  style: TextStyle(
                    fontSize: 50,
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: _cardDecoration(),
        child: Row(
          children: [
            Icon(Icons.person, size: 80, color: AppTheme.primaryColor),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                SizedBox(
                  width: 190,
                  child: Text(
                    mainProvider.waitress!.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'ID: ${mainProvider.waitress!.id}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 8),
                alignment: Alignment.centerRight,
                width: 200,
                height: 200,
                child: IconButton.filled(
                  iconSize: 30,
                  style: IconButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                  ),
                  onPressed: () {
                    mainProvider.waitress = null;
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                  icon: Icon(Icons.login_rounded),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 15)],
    );
  }
}
