import 'package:flutter/material.dart';
import 'package:flutter_application_ngrk/presentation/controllers/order_controller.dart';
import 'package:flutter_application_ngrk/presentation/screens/CreateOrderScreen.dart';
import 'package:flutter_application_ngrk/presentation/screens/OrderDetailScreen.dart';
import 'package:get/get.dart';

class OrdersListScreen extends StatelessWidget {
  final OrderController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getAllOrders();

    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      body: GetBuilder<OrderController>(
        builder: (_) {
          if (controller.allOrders.isEmpty) {
            return Center(child: Text('No orders found.'));
          }

          return ListView.builder(
            itemCount: controller.allOrders.length,
            itemBuilder: (context, index) {
              final order = controller.allOrders[index];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    title: Text(
                      "Order #${order.orderId}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text("Status: ${order.status}"),
                        Text("Total: \$${order.total.toStringAsFixed(2)}"),
                        Text("Quantity: ${order.quantite}"),
                        Text("Items: ${order.orderLines?.length ?? 0}"),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => OrderDetailScreen(order: order),
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => controller.deleteOrder(order.orderId!),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => CreateOrderScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
