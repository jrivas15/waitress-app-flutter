import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:meseros_app/models/table_model.dart';
import 'package:meseros_app/providers/providers.dart';
import 'package:meseros_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

class CustomTable extends StatelessWidget {
  final TableModel table;
  const CustomTable({super.key, required this.table});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final customHeight = size.height * 0.08;
    final customWidth = size.width * 0.20;
    final Logger logger = Logger();

    updateOrderItemsState() {
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      final tableProvider = Provider.of<TableProvider>(context, listen: false);
      if (table.order != null) {
        orderProvider.updateOrderItemsState(
          orderID: table.order!,
          state: tableProvider.gruopOptionsRadioStateProducts!,
        );
      }
      Navigator.pop(context);
    }

    return GestureDetector(
      onLongPress: () {
        // print('table ${table.tableNumber}');
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: Text('Actualizar mesa'),
                content: SizedBox(
                  height: 170,
                  child: Column(
                    children: [
                      _RadioOption(title: 'Pendiente', value: 1),
                      _RadioOption(title: 'En preparación', value: 2),
                      _RadioOption(title: 'Entregado', value: 3),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () => updateOrderItemsState(),
                    child: Text('Actualizar'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.primaryColor,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancelar'),
                  ),
                ],
              ),
        );
      },
      onTap: () {
        // table
        logger.i(table.order);
        final orderProvider = Provider.of<OrderProvider>(
          context,
          listen: false,
        );
        if (table.order != null) {
          orderProvider.resetOrder();
          orderProvider.getOrderItems(table.order!);
        }
        final productProvider = Provider.of<ProductProvider>(
          context,
          listen: false,
        );
        productProvider.getCategories();
        Navigator.pushNamed(context, 'table-details', arguments: table);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment:
                table.capacity > 4
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.center,
            children: [
              _ChairVertical(width: size.width * 0.08),
              table.capacity > 4
                  ? _ChairVertical(width: size.width * 0.08)
                  : SizedBox(),
            ],
          ),
          table.capacity == 4
              ? _ChairHorizontal(width: customWidth + size.width * 0.035)
              : table.capacity > 4
              ? _ChairHorizontal(width: customWidth + size.width * 0.09)
              : SizedBox(),
          table.capacity > 4
              ? _MainTable(
                width: customWidth + size.width * 0.06,
                height: customHeight,
              )
              : _MainTable(width: customWidth, height: customHeight),
          Container(
            alignment: Alignment.center,
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color:
                  table.state == "available"
                      ? Color.fromRGBO(39, 174, 96, 1.0)
                      : table.state == "busy"
                      ? AppTheme.primaryColor
                      : Colors.black87,
            ),
            child: Text(
              table.tableNumber.toString(),
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _RadioOption extends StatelessWidget {
  const _RadioOption({required this.title, required this.value});

  final String title;
  final int value;
  @override
  Widget build(BuildContext context) {
    final tableProvider = Provider.of<TableProvider>(context);
    return RadioListTile<int>(
      title: Text(title),
      value: value,
      groupValue: tableProvider.gruopOptionsRadioStateProducts,
      onChanged:
          (state) => tableProvider.gruopOptionsRadioStateProducts = state ?? 1,
      fillColor: WidgetStateColor.resolveWith(
        (colort) => AppTheme.primaryColor,
      ),
    );
  }
}

class _MainTable extends StatelessWidget {
  final double? height;
  final double? width;
  const _MainTable({this.width = 70, this.height = 70});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromARGB(255, 238, 199, 148),
      ),
    );
  }
}

class _ChairVertical extends StatelessWidget {
  final double? width;
  const _ChairVertical({this.width = 35});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: width,
      //
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: const Color.fromARGB(255, 163, 159, 159),
      ),
    );
  }
}

class _ChairHorizontal extends StatelessWidget {
  final double? width;
  const _ChairHorizontal({this.width = 80});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: width,
      //
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: const Color.fromARGB(255, 163, 159, 159),
      ),
    );
  }
}
