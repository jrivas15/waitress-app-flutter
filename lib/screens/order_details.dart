import 'package:flutter/material.dart';
import 'package:meseros_app/models/order_item_model.dart';
import 'package:meseros_app/models/table_model.dart';
import 'package:meseros_app/providers/providers.dart';
import 'package:meseros_app/theme/app_theme.dart';
import 'package:meseros_app/utils/utils.dart';
import 'package:meseros_app/widgets/dialogs.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatelessWidget {
  final TableModel table;
  const OrderDetails({super.key, required this.table});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    navToHome() => Navigator.pushReplacementNamed(context, '/');

    sendBill() async {
      bool ok = await orderProvider.updateOrderItems();
      ok ? navToHome() : null;
    }

    newOrder() {
      final mainProvider = Provider.of<MainProvider>(context, listen: false);
      table.waitress = mainProvider.waitress!.id;
      orderProvider.newOrder(table: table);
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Text('Cuenta', style: AppTheme.titleStyle),
          // CustomCarrousel(),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ListView.builder(
                itemCount: orderProvider.orderItems.length,
                itemBuilder: (_, int i) {
                  if (orderProvider.orderItems[i].id == null) {
                    orderProvider.orderItems[i].id = -i;
                  }
                  return _OrderItemCard(orderItem: orderProvider.orderItems[i]);
                },
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              'Total \$ ${formatNumber(orderProvider.totalOrderPrice)}',
              textAlign: TextAlign.right,
              style: AppTheme.titleStyle,
            ),
          ),
          ElevatedButton(
            onPressed:
                orderProvider.orderItems.isEmpty
                    ? null
                    : () async {
                      table.order != null ? await sendBill() : newOrder();
                    },
            child: Text('Enviar comanda', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}

class _OrderItemCard extends StatelessWidget {
  final OrderItemModel orderItem;

  const _OrderItemCard({required this.orderItem});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );

    onDoubleTap() {
      Provider.of<OrderProvider>(context, listen: false).currOrderItemID =
          orderItem.id!;
      productProvider.currModifiers = orderItem.modifiers;
      productProvider.currNote = orderItem.note;
      productProvider.getModifiers(orderItem.product.id);
      Navigator.pushNamed(
        context,
        'product-details',
        arguments: orderItem.product,
      );
    }

    return GestureDetector(
      onDoubleTap: orderItem.state != 'pending' ? null : () => onDoubleTap(),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 15, spreadRadius: 5),
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity,
          // height: 130,
          // color: Colors.amber,
          child: Row(
            spacing: 2,
            children: [
              SizedBox(
                width: 25,
                child: Text(
                  textAlign: TextAlign.center,
                  orderItem.quantity.toString(),
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ),
              Text('x'),
              const SizedBox(width: 1),
              _Image(),
              _InfoProduct(orderItem: orderItem),
              _BtnActions(orderItem: orderItem),
            ],
          ),
        ),
      ),
    );
  }
}

class _BtnActions extends StatelessWidget {
  final OrderItemModel orderItem;

  const _BtnActions({required this.orderItem});
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Row(
      children: [
        _CustomIconButton(
          color: AppTheme.primaryColor,
          fx: () {
            orderItem.quantity == 1
                ? QuestionDialog.displayAlert(
                  context: context,
                  content: 'Esta seguro que desea eliminar este producto?',
                  title: 'Eliminar',
                  fx: () => orderProvider.removeProduct(orderItem.id!),
                )
                : orderProvider.removeProduct(orderItem.id!);
          },
          icon: Icons.remove,
          state: orderItem.state,
        ),
        _CustomIconButton(
          color: Colors.green,
          fx: () => orderProvider.addToSameProduct(orderItem.id!),
          icon: Icons.add,
          state: orderItem.state,
        ),
      ],
    );
  }
}

class _CustomIconButton extends StatelessWidget {
  final Color color;
  final VoidCallback fx;
  final IconData icon;
  final dynamic state;
  const _CustomIconButton({
    required this.color,
    required this.fx,
    required this.icon,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: state != 'pending' ? null : fx,
      // onPressed: null,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
    );
  }
}

class _InfoProduct extends StatelessWidget {
  final OrderItemModel orderItem;

  const _InfoProduct({required this.orderItem});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            orderItem.product.name,
            maxLines: 2,
            style: TextStyle(
              fontSize: 15,

              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          orderItem.modifiers.isNotEmpty
              ? Wrap(
                children: List.generate(
                  orderItem.modifiers.length,
                  (i) => Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: Colors.amberAccent,
                        size: 17,
                      ),
                      Text(orderItem.modifiers[i].name),
                    ],
                  ),
                ),
              )
              : SizedBox(),
          Text('Nota: ${orderItem.note ?? " "}'),
          Text('\$ ${formatNumber(orderItem.subtotal)}'),
          Text('Estado: ${orderItem.state}'),
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  // const _Image();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 3),
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
