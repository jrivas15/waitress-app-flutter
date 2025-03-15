import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meseros_app/models/modifier_model.dart';
import 'package:meseros_app/models/order_item_model.dart';
import 'package:meseros_app/models/order_model.dart';
import 'package:meseros_app/models/product_model.dart';
import 'package:meseros_app/models/table_model.dart';
import 'package:meseros_app/shared_preferences/preference.dart';
import 'package:logger/logger.dart';
import 'dart:convert';

class OrderProvider extends ChangeNotifier {
  String backend = '${Preferences.ipServer}:${Preferences.port}';
  OrderModel? currentOrder;
  List<OrderItemModel> orderItems = [];
  double totalOrderPrice = 0;
  int currOrderItemID = 0;
  final Logger logger = Logger();

  addOrderItem(ProductModel product) {
    // print(currentOrder != null);
    if (currentOrder != null) {
      addItemToOrderList(product, order: currentOrder!.id);
    } else {
      addItemToOrderList(product);
    }
    calculateTotalOrderPrice();
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
      modifiers: [],
    );
    orderItems.add(item);
  }

  addToSameProduct(int productID) {
    for (OrderItemModel item in orderItems) {
      if (item.id == productID) {
        item.quantity++;
        item.subtotal = item.quantity * item.product.price;
        break;
      }
    }
    calculateTotalOrderPrice();
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
          item.subtotal = item.quantity * item.product.price;
        }
        calculateTotalOrderPrice();
        notifyListeners();
        break;
      }
    }
  }

  resetOrder() {
    logger.i('RESETTING ORDER-------------');
    currentOrder = null;
    orderItems = [];
    totalOrderPrice = 0;
    notifyListeners();
  }

  calculateTotalOrderPrice() {
    final List<double> subtotals =
        orderItems.map((item) => item.subtotal).toList();
    subtotals.isNotEmpty
        ? totalOrderPrice = subtotals.reduce(
          (value, element) => value + element,
        )
        : totalOrderPrice = 0;

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
      logger.e(error);
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
        logger.i(orderItemModelToJson(orderItems));
      }
      notifyListeners();
    } catch (error) {
      logger.e(error);
    }
  }

  updateOrderItemModifiers(
    ProductModel product,
    List<ModifierModel> modifiers,
    String note,
  ) {
    for (OrderItemModel item in orderItems) {
      if (item.id == currOrderItemID) {
        item.modifiers = modifiers;
        item.note = note;
        logger.d(item.modifiers);
        break;
      }
    }
    notifyListeners();
  }

  List<Map<String, dynamic>> _dataToOrderRequest() {
    //Method to set data to model requiered
    return orderItems
        .map(
          (item) => {
            "id": item.id,
            "quantity": item.quantity,
            "state": item.state,
            "note": item.note,
            "product": item.product.id,
            "subtotal": item.subtotal,
            "modifiers": item.modifiers,
          },
        )
        .toList();
  }

  newOrder({required TableModel table}) async {
    logger.i(table.order);
    final url = Uri.http(backend, 'orders/new');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          "waitressID": table.waitress,
          "table": table.id,
          "orderItems": _dataToOrderRequest(),
        }),
      );
      if (response.statusCode != 200) {
        return false;
      }
    } catch (e) {
      logger.e(e);
      return false;
    }
    return true;
  }

  Future<bool> updateOrderItems() async {
    final int orderID = orderItems[0].order ?? 0;

    final url = Uri.http(backend, 'orders/update-items');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "order": orderID,
          "orderItems": _dataToOrderRequest(),
        }),
      );
      if (response.statusCode != 200) {
        return false;
      }
    } catch (error) {
      logger.e(error);
      return false;
    }
    return true;
  }

  updateOrderItemsState({required int orderID,required int state}) async {
    final url = Uri.http(backend, 'orders/update-order-state');
    try {
      final response = await http.patch(
        url,
        body: json.encode({
          "orderID": orderID,
          "state": state,
        }),
      );
      if (response.statusCode != 200) {
        return false;
      }
    } catch (e) {
      logger.e(e);
      return false;
    }
    return true;
  }
}
