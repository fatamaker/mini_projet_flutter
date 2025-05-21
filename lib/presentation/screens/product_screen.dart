// import 'package:flutter/material.dart';
// import 'package:flutter_application_ngrk/presentation/controllers/article_controller.dart';
// import 'package:flutter_application_ngrk/presentation/screens/ModifierArticleScreen.dart';

// import 'package:get/get.dart';

// class ArticleScreen extends StatelessWidget {
//   final int id;
//   const ArticleScreen({super.key, required this.id});
//   static const imgUrl = 'http://192.168.122.24:5000/images';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Navigator.of(context).pop(),
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//         ),
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//       ),
//       body: GetBuilder<ArticleController>(
//         init: ArticleController(),
//         builder: (controller) {
//           return FutureBuilder(
//             future: controller.getArticleById(id),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasData) {
//                 final article = snapshot.data!;
//                 return Column(
//                   children: [
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               if (article.image != null)
//                                 SizedBox(
//                                     width: double.infinity,
//                                     height: 250,
//                                     child: Image.network(
//                                       '$imgUrl/${article.image}',
//                                       fit: BoxFit.cover,
//                                     )),
//                               const SizedBox(height: 20),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     width: 250,
//                                     child: Text(
//                                       article.nom,
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.w800,
//                                           fontSize: 18),
//                                     ),
//                                   ),
//                                   Text(
//                                     '${article.prix} DT',
//                                     style: const TextStyle(
//                                         color: Color.fromARGB(255, 0, 0, 0),
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 20),
//                               Text(
//                                 article.description,
//                                 style: const TextStyle(
//                                     fontSize: 15, fontWeight: FontWeight.w500),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           ElevatedButton.icon(
//                             onPressed: () {
//                               Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (_) =>
//                                       ModifierArticleScreen(article: article)));
//                             },
//                             icon: const Icon(Icons.edit,
//                                 color: Color.fromARGB(255, 216, 116, 39)),
//                             label: const Text("Modifier",
//                                 style: TextStyle(
//                                     color: Color.fromARGB(255, 216, 116, 39))),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor:
//                                   Colors.grey[300], // neutral light grey
//                             ),
//                           ),
//                           ElevatedButton.icon(
//                             onPressed: () async {
//                               await controller.deleteArticle(id);
//                               Navigator.of(context).pop(); // Ferme l'écran
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       content: Text("Article supprimé")));
//                             },
//                             icon: const Icon(Icons.delete,
//                                 color: Color.fromARGB(255, 183, 5, 5)),
//                             label: const Text("Supprimer",
//                                 style: TextStyle(
//                                     color: Color.fromARGB(255, 183, 5, 5))),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor:
//                                   Colors.grey[200], // slightly lighter neutral
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 );
//               } else {
//                 return const Center(
//                     child: Text('Erreur lors du chargement de l\'article'));
//               }
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_application_ngrk/presentation/controllers/article_controller.dart';
import 'package:flutter_application_ngrk/presentation/screens/ModifierArticleScreen.dart';
import 'package:get/get.dart';

class ArticleScreen extends StatelessWidget {
  final int id;
  const ArticleScreen({super.key, required this.id});
  static const imgUrl = 'http://192.168.246.24:5000/images';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // Remove shadow for a cleaner look
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.grey[100], // Light background for better contrast
      body: GetBuilder<ArticleController>(
        init: ArticleController(),
        builder: (controller) {
          return FutureBuilder(
            future: controller.getArticleById(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                final article = snapshot.data!;
                return SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (article.image != null)
                                Container(
                                  margin: const EdgeInsets.only(bottom: 16.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 220,
                                      child: Image.network(
                                        '$imgUrl/${article.image}',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Center(
                                              child: Icon(
                                                  Icons.image_not_supported,
                                                  size: 50,
                                                  color: Colors.grey));
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              Text(
                                article.nom,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.black87),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${article.prix} DT',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${article.stock} en stock',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                article.description,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => ModifierArticleScreen(
                                        article: article)));
                              },
                              icon: const Icon(Icons.edit, color: Colors.white),
                              label: const Text("Modifier",
                                  style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 223, 174, 12),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                elevation: 2,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () async {
                                await controller.deleteArticle(id);
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Article supprimé")));
                              },
                              icon:
                                  const Icon(Icons.delete, color: Colors.white),
                              label: const Text("Supprimer",
                                  style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 220, 80, 70),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                elevation: 2,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return const Center(
                    child: Text('Erreur lors du chargement de l\'article'));
              }
            },
          );
        },
      ),
    );
  }
}
