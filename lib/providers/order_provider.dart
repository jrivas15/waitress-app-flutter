import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meseros_app/models/order_item_model.dart';
import 'package:meseros_app/models/order_model.dart';
import 'package:meseros_app/models/product_model.dart';
import 'package:meseros_app/shared_preferences/preference.dart';
import 'package:logger/logger.dart';
import 'dart:convert';

class OrderProvider extends ChangeNotifier {
  String backend = '${Preferences.ipServer}:${Preferences.port}';
  OrderModel? currentOrder;
  List<OrderItemModel> orderItems = [];
  final Logger logger = Logger();

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
      state: "pending",
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

  resetOrder() {
    logger.i('RESETTING ORDER-------------');
    currentOrder = null;
    orderItems = [];
    notifyListeners();
  }

  getOrderDetailsByID(int orderID) async {
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
      logger.e(error);
    }
  }

  updateOrderItems() async {
    final url = Uri.http(backend, 'orders/get-items', {
      "orderID": orderID.toString(),
    });
    try {
      final response = await http.post(url);
      if (response.statusCode != 200) {
        orderItems = [];
      } else {
        orderItems = orderItemModelFromJson(response.body);
      }
      notifyListeners();
    } catch (error) {
      logger.e(error);
    }
  }

  Future<void> createOrder(OrderModel order) async {
    final url = Uri.http(backend, 'orders/create');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(order.toJson()),
      );
      if (response.statusCode == 201) {
        logger.i('Order created successfully');
      } else {
        logger.e('Failed to create order: ${response.body}');
      }
    } catch (error) {
      logger.e('Error creating order: $error');
    }
  }
}
