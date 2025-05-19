// import 'package:flutter/material.dart';
// import 'package:flutter_application_ngrk/data/models/article_model.dart';
// import 'package:flutter_application_ngrk/domain/entities/article.dart';
// import 'package:flutter_application_ngrk/presentation/controllers/article_controller.dart';
// import 'package:get/get.dart';

// class ModifierArticleScreen extends StatefulWidget {
//   final Article article;

//   const ModifierArticleScreen({super.key, required this.article});

//   @override
//   State<ModifierArticleScreen> createState() => _ModifierArticleScreenState();
// }

// class _ModifierArticleScreenState extends State<ModifierArticleScreen> {
//   late TextEditingController nomController;
//   late TextEditingController prixController;
//   late TextEditingController descriptionController;
//   late TextEditingController imageController;

//   @override
//   void initState() {
//     super.initState();
//     nomController = TextEditingController(text: widget.article.nom);
//     prixController =
//         TextEditingController(text: widget.article.prix.toString());
//     descriptionController =
//         TextEditingController(text: widget.article.description);
//     imageController = TextEditingController(text: widget.article.image ?? '');
//   }

//   @override
//   void dispose() {
//     nomController.dispose();
//     prixController.dispose();
//     descriptionController.dispose();
//     imageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ArticleController>(
//       builder: (controller) {
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text("Modifier Article"),
//             backgroundColor: Color.fromARGB(255, 216, 116, 39),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: nomController,
//                     decoration: const InputDecoration(labelText: "Nom"),
//                   ),
//                   const SizedBox(height: 10),
//                   TextField(
//                     controller: prixController,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(labelText: "Prix"),
//                   ),
//                   const SizedBox(height: 10),
//                   TextField(
//                     controller: descriptionController,
//                     maxLines: 3,
//                     decoration: const InputDecoration(labelText: "Description"),
//                   ),
//                   const SizedBox(height: 10),
//                   TextField(
//                     controller: imageController,
//                     decoration: const InputDecoration(
//                         labelText: "Image URL (optionnel)"),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton.icon(
//                     onPressed: () async {
//                       final updatedArticleModel = ArticleModel(
//                         id: widget.article.id,
//                         nom: nomController.text,
//                         prix: int.tryParse(prixController.text) ?? 0,
//                         description: descriptionController.text,
//                         image: imageController.text,
//                       );

//                       final success =
//                           await controller.updateArticle(updatedArticleModel);
//                       if (success) {
//                         Navigator.of(context).pop(); // Ferme l'écran
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                               content: Text("Article modifié avec succès")),
//                         );
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                               content: Text(
//                                   "Échec de la modification de l'article")),
//                         );
//                       }
//                     },
//                     icon: const Icon(Icons.save),
//                     label: const Text("Enregistrer"),
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Color.fromARGB(255, 216, 116, 39)),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_application_ngrk/data/models/article_model.dart';
import 'package:flutter_application_ngrk/domain/entities/article.dart';
import 'package:flutter_application_ngrk/presentation/controllers/article_controller.dart';
import 'package:get/get.dart';

class ModifierArticleScreen extends StatefulWidget {
  final Article article;

  const ModifierArticleScreen({super.key, required this.article});

  @override
  State<ModifierArticleScreen> createState() => _ModifierArticleScreenState();
}

class _ModifierArticleScreenState extends State<ModifierArticleScreen> {
  late TextEditingController nomController;
  late TextEditingController prixController;
  late TextEditingController descriptionController;
  late TextEditingController imageController;
  late TextEditingController stockController;

  @override
  void initState() {
    super.initState();
    nomController = TextEditingController(text: widget.article.nom);
    prixController =
        TextEditingController(text: widget.article.prix.toString());
    descriptionController =
        TextEditingController(text: widget.article.description);
    imageController = TextEditingController(text: '');
    stockController =
        TextEditingController(text: widget.article.stock.toString());
  }

  @override
  void dispose() {
    nomController.dispose();
    prixController.dispose();
    descriptionController.dispose();
    imageController.dispose();
    stockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArticleController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Modifier Article",
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),

            elevation: 0, // Remove shadow
            iconTheme: const IconThemeData(
                color: Color.fromARGB(255, 0, 0, 0)), // White back arrow
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Stylish Input Fields
                  TextFormField(
                    controller: nomController,
                    decoration: InputDecoration(
                      labelText: "Nom",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 85, 137, 200)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: prixController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Prix",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(81, 85, 137, 200)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  TextFormField(
                    controller: stockController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "stock",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(81, 85, 137, 200)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 85, 137, 200)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // TextFormField(
                  //   controller: imageController,
                  //   decoration: InputDecoration(
                  //     labelText: "Image URL (optionnel)",
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8.0),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderSide: const BorderSide(
                  //           color: Color.fromARGB(255, 223, 174, 12)),
                  //       borderRadius: BorderRadius.circular(8.0),
                  //     ),
                  //     filled: true,
                  //     fillColor: Colors.white,
                  //   ),
                  // ),
                  const SizedBox(height: 24),
                  // Elevated Save Button with Icon
                  ElevatedButton.icon(
                    onPressed: () async {
                      final updatedArticleModel = ArticleModel(
                        id: widget.article.id,
                        nom: nomController.text,
                        prix: int.tryParse(prixController.text) ?? 0,
                        description: descriptionController.text,
                        image: imageController.text,
                        stock: int.tryParse(stockController.text) ?? 0,
                      );

                      final success =
                          await controller.updateArticle(updatedArticleModel);
                      if (success) {
                        Navigator.of(context).pop(); // Close the screen
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Article modifié avec succès")),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  "Échec de la modification de l'article")),
                        );
                      }
                    },
                    icon: const Icon(Icons.save, color: Colors.white),
                    label: const Text("Enregistrer",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 223, 174, 12),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
