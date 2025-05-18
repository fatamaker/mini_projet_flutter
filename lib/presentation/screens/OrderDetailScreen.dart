// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_application_ngrk/data/models/order_model.dart';
// import 'package:flutter_application_ngrk/data/models/order_line_model.dart';
// import 'package:flutter_application_ngrk/presentation/controllers/user_controller.dart'; // adjust path if needed

// class OrderDetailScreen extends StatelessWidget {
//   final OrderModel order;

//   OrderDetailScreen({super.key, required this.order});

//   final UserController userController = Get.put(UserController());

//   @override
//   Widget build(BuildContext context) {
//     final lines = order.orderLines;

//     return Scaffold(
//       appBar: AppBar(title: Text('Commande #${order.orderId}')),
//       body: FutureBuilder(
//         future: userController.getUserById(order.userId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final user = snapshot.data;

//           return Padding(
//             padding: const EdgeInsets.all(16),
//             child: ListView(
//               children: [
//                 Text("Statut : ${order.status}",
//                     style: const TextStyle(fontSize: 18)),
//                 const SizedBox(height: 8),
//                 Text("Total : \$${order.total}",
//                     style: const TextStyle(fontSize: 18)),
//                 const SizedBox(height: 8),
//                 Text("Quantité : ${order.quantite}",
//                     style: const TextStyle(fontSize: 18)),
//                 const SizedBox(height: 8),
//                 Text(
//                   user != null
//                       ? "Utilisateur : ${user.nameUser} (${user.emailUser})"
//                       : "Utilisateur : Non trouvé",
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 20),
//                 const Text("Articles commandés :",
//                     style:
//                         TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 8),

//                 // Display order lines
//                 ...lines.map<Widget>((OrderLineModel line) {
//                   return Card(
//                     elevation: 2,
//                     margin: const EdgeInsets.symmetric(vertical: 6),
//                     child: ListTile(
//                       leading: const Icon(Icons.shopping_cart),
//                       title: Text("ID Article : ${line.articleId}"),
//                       subtitle: Text("Quantité : ${line.quantity}"),
//                     ),
//                   );
//                 }).toList(),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_ngrk/data/models/order_model.dart';
import 'package:flutter_application_ngrk/data/models/order_line_model.dart';
import 'package:flutter_application_ngrk/presentation/controllers/user_controller.dart'; // adjust path if needed

class OrderDetailScreen extends StatelessWidget {
  final OrderModel order;

  OrderDetailScreen({super.key, required this.order});

  final UserController userController = Get.put(UserController());

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildOrderInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label : ",
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lines = order.orderLines;

    return Scaffold(
      appBar: AppBar(title: Text('Commande #${order.orderId}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Informations de la commande"),
            _buildOrderInfo("Statut", order.status),
            _buildOrderInfo("Total", "\$${order.total}"),
            _buildOrderInfo("Quantité", "${order.quantite}"),
            const SizedBox(height: 16),
            _buildSectionTitle("Informations de l'utilisateur"),
            FutureBuilder(
              future: userController.getUserById(order.userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final user = snapshot.data;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOrderInfo(
                      "Utilisateur",
                      user != null
                          ? "${user.nameUser} (${user.emailUser})"
                          : "Non trouvé",
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("Articles commandés"),
            if (lines.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text("Aucun article dans cette commande."),
              )
            else
              ...lines.map<Widget>((OrderLineModel line) {
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.shopping_cart),
                    title: Text("ID Article : ${line.articleId}"),
                    subtitle: Text("Quantité : ${line.quantity}"),
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }
}
