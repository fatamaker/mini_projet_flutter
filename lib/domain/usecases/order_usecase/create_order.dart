import 'package:flutter_application_ngrk/data/models/order_model.dart';
import 'package:flutter_application_ngrk/domain/repository/order_repository.dart';

class CreateOrder {
  final OrderRepository repository;

  CreateOrder(this.repository);

  Future<OrderModel> call(OrderModel order) async {
    return await repository.createOrder(order);
  }
}
