import 'package:flutter/material.dart';
import 'package:meseros_app/models/table_model.dart';
import 'package:meseros_app/providers/table_provider.dart';
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
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black12),
              child: Row(
                spacing: 10,
                children: [
                  BackButton(),
                  CustomTable(table: table),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mesa: ${table.tableNumber}',
                      ),
                      Text('Zona: ${tableProvider.selectedZone.name}'),
                      Text('Estado: ${table.state}')
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
