import 'package:flutter/material.dart';
import 'package:meseros_app/models/order_item_model.dart';
import 'package:meseros_app/providers/order_provider.dart';
import 'package:meseros_app/theme/app_theme.dart';
import 'package:meseros_app/utils/utils.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Expanded(
      child: Column(
        children: [
          Text('Cuenta', style: AppTheme.titleStyle),
          // CustomCarrousel(),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              // color: Colors.blue,
              // child: Column(children: [_OrderItemCard(),]),
              child: ListView.builder(
                itemCount: orderProvider.orderItems.length,
                itemBuilder: (_, int i) {
                  if (orderProvider.currentOrder == null) {
                    orderProvider.orderItems[i].id = i;
                  }
                  return _OrderItemCard(orderItem: orderProvider.orderItems[i]);
                },
              ),
            ),
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
    return GestureDetector(
      onDoubleTap: () {
        print('editar producto');
      },
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
              _BtnActions(orderID: orderItem.id!),
            ],
          ),
        ),
      ),
    );
  }
}

class _BtnActions extends StatelessWidget {
  final int orderID;

  const _BtnActions({required this.orderID});
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Row(
      children: [
        IconButton.filled(
          onPressed: () => orderProvider.removeProduct(orderID),
          icon: Icon(Icons.remove),
          style: IconButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
          ),
        ),
        IconButton.filled(
          onPressed: () {
            orderProvider.addToSameProduct(orderID);
          },
          icon: Icon(Icons.add),
          style: IconButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _InfoProduct extends StatelessWidget {
  final OrderItemModel orderItem;

  const _InfoProduct({required this.orderItem});

  @override
  Widget build(BuildContext context) {
    final List<String> modifiers = [
      // "Con cebolla",
      // "Extra queso",
      // "Extra queso",
      // "Extra queso",
      // "Extra queso",
      // "Extra queso",
    ];
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

          modifiers.isNotEmpty
              ? Wrap(
                children: List.generate(
                  modifiers.length,
                  (i) => Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: Colors.amberAccent,
                        size: 17,
                      ),
                      Text(modifiers[i]),
                    ],
                  ),
                ),
              )
              : SizedBox(),
          Text('Nota: ${orderItem.note ?? " "}'),
          Text('\$ ${formatNumber(orderItem.subtotal)}'),
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image();

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
