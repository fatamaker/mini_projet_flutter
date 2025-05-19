import 'order_line_model.dart';

//status and quantitie plus the duplication of the order line and the decrse of the stock in the product
class OrderModel {
  final int? orderId;
  final String status;
  final int quantite;
  final double total;
  final int userId;
  final List<OrderLineModel> orderLines;

  OrderModel({
    this.orderId,
    required this.status,
    required this.quantite,
    required this.total,
    required this.userId,
    required this.orderLines,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'],
      status: json['status'],
      quantite: json['quantite'],
      total: json['total'],
      userId: json['user']['idUser'],
      orderLines: (json['orderLines'] as List)
          .map((e) => OrderLineModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'status': status,
        'quantite': quantite,
        'total': total,
      };
}
