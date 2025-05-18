import 'package:flutter_application_ngrk/data/models/order_model.dart';
import 'package:flutter_application_ngrk/domain/repository/order_repository.dart';

class GetAllOrders {
  final OrderRepository repository;

  GetAllOrders(this.repository);

  Future<List<OrderModel>> call() async {
    return await repository.getAllOrders();
  }
}
