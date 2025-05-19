import 'package:flutter_application_ngrk/domain/repository/order_repository.dart';

class UpdateOrderStatusUseCase {
  final OrderRepository repository;

  UpdateOrderStatusUseCase(this.repository);

  Future<void> call(int orderId, String newStatus) {
    return repository.updateOrderStatus(orderId, newStatus);
  }
}
