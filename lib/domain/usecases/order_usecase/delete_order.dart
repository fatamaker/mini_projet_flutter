import 'package:flutter_application_ngrk/domain/repository/order_repository.dart';

class DeleteOrder {
  final OrderRepository repository;

  DeleteOrder(this.repository);

  Future<void> call(int id) async {
    return await repository.deleteOrder(id);
  }
}
