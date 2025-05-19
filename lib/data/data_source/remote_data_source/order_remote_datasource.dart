import 'package:flutter_application_ngrk/core/utils/api_const.dart';
import 'package:flutter_application_ngrk/data/models/order_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getAllOrders();
  Future<void> deleteOrder(int id);
  Future<OrderModel> createOrder(OrderModel order);
  Future<void> updateOrderStatus(int orderId, String newStatus);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  @override
  Future<List<OrderModel>> getAllOrders() async {
    final response = await http.get(Uri.parse(APIConst.orders));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => OrderModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch orders');
    }
  }

  @override
  Future<void> deleteOrder(int id) async {
    final response = await http.delete(Uri.parse('${APIConst.orders}/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete order');
    }
  }

  @override
  Future<OrderModel> createOrder(OrderModel order) async {
    final response = await http.post(
      Uri.parse('${APIConst.orders}/createWithLines?userId=${order.userId}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'order': order.toJson(),
        'orderLines': order.orderLines.map((e) => e.toJson()).toList(),
      }),
    );

    if (response.statusCode == 200) {
      return OrderModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create order');
    }
  }

  @override
  Future<void> updateOrderStatus(int orderId, String newStatus) async {
    final url =
        Uri.parse('${APIConst.orders}/$orderId/status?status=$newStatus');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update order status');
    }
  }
}
