import 'package:flutter/material.dart';
import 'package:meseros_app/models/table_model.dart';
import 'package:meseros_app/providers/table_provider.dart';
import 'package:meseros_app/screens/order_details.dart';
import 'package:meseros_app/screens/select_products.dart';
import 'package:meseros_app/theme/app_theme.dart';
import 'package:meseros_app/widgets/custom_table.dart';
import 'package:provider/provider.dart';

class TableDetails extends StatelessWidget {
  const TableDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final TableModel table =
        ModalRoute.of(context)!.settings.arguments as TableModel;
    final tableProvider = Provider.of<TableProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 15,
          children: [
            _InfoTable(table: table, tableProvider: tableProvider),
            _SwitchScreen(),
          ],
        ),
      ),
      bottomNavigationBar: _TableNavigationBart(),
    );
  }
}

class _SwitchScreen extends StatelessWidget {
  const _SwitchScreen();

  @override
  Widget build(BuildContext context) {
    final tableProvider = Provider.of<TableProvider>(context, listen: false);
    final currentIndex = tableProvider.currentOptNav;

    switch (currentIndex) {
      case 0:
        return SelectProducts();
      case 1:
        return OrderDetails();
      default:
        return const SelectProducts();
    }
  }
}

class _TableNavigationBart extends StatelessWidget {
  const _TableNavigationBart();

  @override
  Widget build(BuildContext context) {
    final tableProvider = Provider.of<TableProvider>(context, listen: false);
    return BottomNavigationBar(
      backgroundColor: const Color.fromRGBO(25, 25, 25, 1),
      currentIndex: tableProvider.currentOptNav,
      onTap: (int index) {
        tableProvider.currentOptNav = index;
      },
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.fastfood_sharp),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Badge.count(
            count: 0,
            child: const Icon(Icons.shopping_bag_rounded),
          ),
          label: '',
        ),
      ],
      selectedItemColor: const Color.fromRGBO(214, 48, 49, 1),
      unselectedItemColor: Colors.white,
    );
  }
}

class _InfoTable extends StatelessWidget {
  const _InfoTable({required this.table, required this.tableProvider});

  final TableModel table;
  final TableProvider tableProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black12,
      ),
      child: Row(
        spacing: 10,
        children: [
          BackButton(),
          CustomTable(table: table),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mesa: ${table.tableNumber}'),
              Text('Zona: ${tableProvider.selectedZone.name}'),
              Text('Atendida por: ${table.state}'),
            ],
          ),
        ],
      ),
    );
  }
}
