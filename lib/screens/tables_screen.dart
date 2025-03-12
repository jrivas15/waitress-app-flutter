import 'package:flutter/material.dart';
import 'package:meseros_app/models/table_model.dart';
import 'package:meseros_app/models/zone_model.dart';
import 'package:meseros_app/providers/product_provider.dart';
import 'package:meseros_app/providers/table_provider.dart';
import 'package:meseros_app/theme/app_theme.dart';
import 'package:meseros_app/widgets/custom_table.dart';
import 'package:provider/provider.dart';

class TablesScreen extends StatelessWidget {
  const TablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tableProvider = Provider.of<TableProvider>(context);
    final List<TableModel> tables = tableProvider.tables;
    final selectedZone = tableProvider.selectedZone;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              selectedZone.id == 0 ? 'Seleccione una zona' : selectedZone.name,
              style: TextStyle(fontSize: 30),
            ),

            selectedZone.id == 0
                ? Icon(
                  Icons.table_restaurant_rounded,
                  color: Colors.black54,
                  size: 60,
                )
                : SizedBox(),

            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                children:
                    tables.isNotEmpty
                        ? tables
                            .map((table) => CustomTable(table: table))
                            .toList()
                        : [],
              ),
            ),
            _ZoneCategories(),
          ],
        ),
      ),
    );
  }
}

class _ZoneCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final tableProvider = Provider.of<TableProvider>(context);
    final List<ZonesModel> zones = tableProvider.zones;
    final selectedZone = tableProvider.selectedZone;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      // color: Colors.amberAccent,
      height: size.height * 0.08,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: zones.length,
        itemBuilder: (_, int i) {
          return GestureDetector(
            onTap: () {
              tableProvider.selectedZone = zones[i];
              tableProvider.getTablesByZone(zones[i].id);
              final productProvider = Provider.of<ProductProvider>(
                context,
                listen: false,
              );
              productProvider.getCategories();
            },
            child: Container(
              height: 10,
              width: size.width * 0.27,
              alignment: Alignment.center,
              decoration:
                  selectedZone.id == zones[i].id
                      ? AppTheme.boxDecorationInfoCards
                      : BoxDecoration(
                        color: const Color.fromARGB(136, 108, 108, 108),
                        borderRadius: BorderRadius.circular(40),
                      ),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  zones[i].name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
