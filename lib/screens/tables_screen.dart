import 'package:flutter/material.dart';
import 'package:meseros_app/models/table_model.dart';
import 'package:meseros_app/providers/table_provider.dart';
import 'package:meseros_app/theme/app_theme.dart';
import 'package:meseros_app/widgets/custom_table.dart';
import 'package:provider/provider.dart';

class TablesScreen extends StatelessWidget {
  const TablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tableProvider = Provider.of<TableProvider>(context);
    final size = MediaQuery.of(context).size;
    const zones = ['Todas', 'Zona 1222222222', 'Zona 2', 'Zona 3', 'Zona 4'];
    final tables = [
      TableModel(
        id: 1,
        capacity: 4,
        state: 'busy',
        tableNumber: 1,
        zone: 'Zone 1',
      ),
      TableModel(
        id: 2,
        capacity: 6,
        state: 'available',
        tableNumber: 2,
        zone: 'Zone 1',
      ),
      TableModel(
        id: 3,
        capacity: 2,
        state: 'busy',
        tableNumber: 3,
        zone: 'Zone 1',
      ),
      TableModel(
        id: 4,
        capacity: 6,
        state: 'available',
        tableNumber: 4,
        zone: 'Zone 1',
      ),
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(tableProvider.selectedZone, style: TextStyle(fontSize: 30)),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                children:
                    tables.map((table) => CustomTable(table: table)).toList(),
              ),
            ),

            _ZoneCategories(size: size, zones: zones),
          ],
        ),
      ),
    );
  }
}

class _ZoneCategories extends StatelessWidget {
  const _ZoneCategories({required this.size, required this.zones});

  final Size size;
  final List<String> zones;

  @override
  Widget build(BuildContext context) {
    final tableProvider = Provider.of<TableProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      // color: Colors.amberAccent,
      // height: size.height * 0.08,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: zones.length,
        itemBuilder: (_, int i) {
          return GestureDetector(
            onTap: (){
              final tableProvider = Provider.of<TableProvider>(context, listen: false);
              tableProvider.selectedZone =zones[i];
            },
            child: Container(
              // height: 40,
              width: size.width * 0.25,
              alignment: Alignment.center,
              decoration: tableProvider.selectedZone == zones[i] ? AppTheme.boxDecorationInfoCards:BoxDecoration(
                color: const Color.fromARGB(137, 165, 165, 165)
              ),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  zones[i],
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
