import 'package:flutter_application_ngrk/domain/usecases/order_usecase/UpdateOrderStatusUseCase.dart';
import 'package:flutter_application_ngrk/domain/usecases/order_usecase/create_order.dart';
import 'package:flutter_application_ngrk/domain/usecases/order_usecase/delete_order.dart';
import 'package:flutter_application_ngrk/domain/usecases/order_usecase/get_all_orders.dart';
import 'package:get/get.dart';
import 'package:flutter_application_ngrk/data/models/order_model.dart';

import 'package:flutter_application_ngrk/di.dart';

class OrderController extends GetxController {
  List<OrderModel> allOrders = [];
  List<OrderModel> ordersList = [];

  /// Fetch all orders
  Future<bool> getAllOrders() async {
    try {
      final result = await GetAllOrders(sl())();
      ordersList = result;
      allOrders = result;
      update();
      return true;
    } catch (e) {
      print('Error getting orders: $e');
      return false;
    }
  }

  /// Add new order
  Future<bool> createOrder(OrderModel order) async {
    try {
      await CreateOrder(sl())(order);
      await getAllOrders();
      return true;
    } catch (e) {
      print('Error creating order: $e');
      return false;
    }
  }

  /// Delete order by ID
  Future<bool> deleteOrder(int id) async {
    try {
      await DeleteOrder(sl())(id);
      await getAllOrders();
      return true;
    } catch (e) {
      print('Error deleting order: $e');
      return false;
    }
  }

  Future<void> updateOrderStatus(int orderId, String newStatus) async {
    try {
      await sl<UpdateOrderStatusUseCase>().call(orderId, newStatus);

      // Optional: Refresh the order list
      await getAllOrders();
    } catch (e) {
      Get.snackbar("Error", "Failed to update order status");
    }
  }
}
