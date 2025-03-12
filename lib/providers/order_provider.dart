import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meseros_app/models/order_item_model.dart';
import 'package:meseros_app/models/order_model.dart';
import 'package:meseros_app/models/product_model.dart';
import 'package:meseros_app/shared_preferences/preference.dart';

class OrderProvider extends ChangeNotifier {
  String backend = '${Preferences.ipServer}:${Preferences.port}';
  OrderModel? currentOrder;
  List<OrderItemModel> orderItems = [];

  addOrderItem(ProductModel product) {
    // print(currentOrder != null);
    if (currentOrder != null) {
      addItemToOrderList(product, order: currentOrder!.id);
    } else {
      addItemToOrderList(product);
    }
    notifyListeners();
  }

  addItemToOrderList(ProductModel product, {int? order}) {
    final OrderItemModel item = OrderItemModel(
      order: order,
      quantity: 1,
      note: '',
      product: product,
      subtotal: product.price,
    );
    orderItems.add(item);
  }

  addToSameProduct(int productID) {
    for (OrderItemModel item in orderItems) {
      if (item.id == productID) {
        item.quantity++;
        break;
      }
    }
    notifyListeners();
  }

  removeProduct(int productID) {
    for (OrderItemModel item in orderItems) {
      if (item.id == productID) {
        if (item.quantity == 1) {
          //*remove item from order list
          orderItems.removeWhere(
            (itemToRemove) => itemToRemove.id == productID,
          );
        } else {
          item.quantity--;
        }
        notifyListeners();
        break;
      }
    }
  }

  getOrder() {}

  getOrderItems(int orderID) async {
    final url = Uri.http(backend, 'orders/get-items', {
      "orderID": orderID.toString(),
    });
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        orderItems = [];
      } else {
        orderItems = orderItemModelFromJson(response.body);
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
