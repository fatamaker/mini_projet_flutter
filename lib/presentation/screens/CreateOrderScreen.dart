import 'package:flutter/material.dart';
import 'package:flutter_application_ngrk/data/models/UserModel.dart';
import 'package:flutter_application_ngrk/data/models/article_model.dart';
import 'package:flutter_application_ngrk/data/models/order_line_model.dart';
import 'package:flutter_application_ngrk/data/models/order_model.dart';
import 'package:flutter_application_ngrk/domain/entities/article.dart'; // Article ici
import 'package:flutter_application_ngrk/presentation/controllers/order_controller.dart';
import 'package:flutter_application_ngrk/presentation/controllers/user_controller.dart';
import 'package:flutter_application_ngrk/presentation/controllers/article_controller.dart';
import 'package:get/get.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({Key? key}) : super(key: key);

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final statusController = TextEditingController();
  final quantiteController = TextEditingController();
  final totalController = TextEditingController();
  final lineQuantityController = TextEditingController();

  final userController = Get.find<UserController>();
  final articleController = Get.find<ArticleController>();
  final orderController = Get.find<OrderController>();

  List<UserModel> users = [];
  List<Article> articles = [];

  UserModel? selectedUser;
  Article? selectedArticle; // Ici c’est Article, pas ArticleModel

  List<OrderLineModel> lines = [];

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  void loadInitialData() async {
    bool usersLoaded = await userController.getAllUsers();
    bool articlesLoaded = await articleController.getAllArticles();

    if (usersLoaded && articlesLoaded) {
      setState(() {
        users = userController.usersList;
        articles = articleController.articlesList;
      });
    } else {
      Get.snackbar(
          'Erreur', 'Erreur lors du chargement des utilisateurs ou articles');
    }
  }

  void addLine() {
    final quantity = int.tryParse(lineQuantityController.text);
    if (selectedArticle != null && quantity != null) {
      final alreadyExists =
          lines.any((line) => line.articleId == selectedArticle!.id);

      if (alreadyExists) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Attention'),
            content: const Text('Cet article a déjà été ajouté.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return;
      }

      setState(() {
        lines.add(OrderLineModel(
          quantity: quantity,
          articleId: selectedArticle!.id,
        ));
        selectedArticle = null;
        lineQuantityController.clear();
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erreur'),
          content:
              const Text('Veuillez sélectionner un article et une quantité.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void submitOrder() {
    if (selectedUser == null) {
      Get.snackbar('Erreur', 'Veuillez sélectionner un utilisateur');
      return;
    }

    final order = OrderModel(
      status: statusController.text,
      quantite: 0,
      total: 0,
      userId: selectedUser!.idUser,
      orderLines: lines,
    );

    orderController.createOrder(order);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Créer une commande')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Infos Commande
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Informations de la commande',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<UserModel>(
                      value: selectedUser,
                      items: users.map((user) {
                        return DropdownMenuItem(
                          value: user,
                          child: Text('${user.nameUser} (ID: ${user.idUser})'),
                        );
                      }).toList(),
                      onChanged: (value) =>
                          setState(() => selectedUser = value),
                      decoration:
                          const InputDecoration(labelText: 'Utilisateur'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: statusController,
                      decoration: const InputDecoration(labelText: 'Statut'),
                    ),
                    const SizedBox(height: 10),
                    // TextField(
                    //   controller: quantiteController,
                    //   decoration:
                    //       const InputDecoration(labelText: 'Quantité totale'),
                    //   keyboardType: TextInputType.number,
                    // ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Section: Ajouter une ligne
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ajouter une ligne de commande',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<Article>(
                      value: selectedArticle,
                      items: articles.map((article) {
                        return DropdownMenuItem(
                          value: article,
                          child: Text('${article.nom} (ID: ${article.id})'),
                        );
                      }).toList(),
                      onChanged: (value) =>
                          setState(() => selectedArticle = value),
                      decoration: const InputDecoration(labelText: 'Article'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: lineQuantityController,
                      decoration: const InputDecoration(labelText: 'Quantité'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: addLine,
                        icon: const Icon(Icons.add),
                        label: const Text('Ajouter la ligne'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Section: Lignes ajoutées
            if (lines.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Lignes de commande ajoutées :',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  ...lines.asMap().entries.map((entry) {
                    final index = entry.key;
                    final line = entry.value;
                    final articleName = articles
                        .firstWhere(
                          (a) => a.id == line.articleId,
                          orElse: () => ArticleModel(
                            id: 0,
                            nom: 'Inconnu',
                            description: '',
                            image: '',
                            prix: 0,
                            stock: 0,
                          ),
                        )
                        .nom;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading: const Icon(Icons.article),
                        title: Text(articleName),
                        subtitle: Text('Quantité: ${line.quantity}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () =>
                              setState(() => lines.removeAt(index)),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),

            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: submitOrder,
                icon: const Icon(Icons.send),
                label: const Text('Soumettre la commande'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
