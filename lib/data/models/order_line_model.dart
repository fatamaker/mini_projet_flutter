class OrderLineModel {
  final int? id;
  final int quantity;
  final int articleId;

  OrderLineModel({this.id, required this.quantity, required this.articleId});

  factory OrderLineModel.fromJson(Map<String, dynamic> json) {
    return OrderLineModel(
      id: json['id'],
      quantity: json['quantity'],
      articleId: json['article']['id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'article': {'id': articleId},
      };
}
