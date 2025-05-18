import 'package:flutter_application_ngrk/data/models/order_model.dart';

abstract class OrderRepository {
  Future<List<OrderModel>> getAllOrders();
  Future<void> deleteOrder(int id);
  Future<OrderModel> createOrder(OrderModel order);
}
