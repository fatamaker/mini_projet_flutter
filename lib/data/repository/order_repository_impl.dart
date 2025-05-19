import 'package:flutter_application_ngrk/data/data_source/remote_data_source/order_remote_datasource.dart';
import 'package:flutter_application_ngrk/data/models/order_model.dart';
import 'package:flutter_application_ngrk/domain/repository/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<OrderModel>> getAllOrders() async {
    return await remoteDataSource.getAllOrders();
  }

  @override
  Future<void> deleteOrder(int id) async {
    return await remoteDataSource.deleteOrder(id);
  }

  @override
  Future<OrderModel> createOrder(OrderModel order) async {
    return await remoteDataSource.createOrder(order);
  }

  @override
  Future<void> updateOrderStatus(int orderId, String newStatus) {
    return remoteDataSource.updateOrderStatus(orderId, newStatus);
  }
}
