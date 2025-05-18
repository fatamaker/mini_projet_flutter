// import 'package:flutter/material.dart';
// import 'package:flutter_application_ngrk/core/utils/text_style.dart';
// import 'package:flutter_application_ngrk/presentation/controllers/article_controller.dart';

// import 'package:flutter_application_ngrk/presentation/screens/product_screen.dart';
// import 'package:flutter_application_ngrk/presentation/widgets/input_search.dart';
// import 'package:flutter_application_ngrk/presentation/widgets/product_item.dart';
// import 'package:get/get.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             backgroundColor: Colors.white,
//             flexibleSpace: const FlexibleSpaceBar(
//               background: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Padding(
//                     padding: EdgeInsets.all(20.0),
//                     child: InputSearch(),
//                   )),
//             ),
//             expandedHeight: MediaQuery.sizeOf(context).height * 0.17,
//             floating: true,
//             snap: true,
//             shadowColor: Colors.black,
//           ),
//           const SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 20.0,
//               ),
//               child: Text(
//                 'Products',
//                 style: ConstTextStyle.smallTitleTextStyle,
//               ),
//             ),
//           ),
//           SliverPadding(
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             sliver: GetBuilder<ArticleController>(
//               init: ArticleController(),
//               builder: (articleController) {
//                 // Effectue la récupération des articles si ce n'est pas déjà fait
//                 if (articleController.articlesList.isEmpty) {
//                   articleController.getAllArticles();
//                 }

//                 return FutureBuilder(
//                   future: articleController.getAllArticles(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const SliverToBoxAdapter(
//                         child: Center(child: CircularProgressIndicator()),
//                       );
//                     } else if (snapshot.hasError) {
//                       return const SliverToBoxAdapter(
//                         child: Center(child: Text('Error loading articles')),
//                       );
//                     } else if (snapshot.hasData ||
//                         articleController.articlesList.isNotEmpty) {
//                       return SliverGrid(
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           mainAxisSpacing: 2,
//                           crossAxisSpacing: 2,
//                         ),
//                         delegate: SliverChildBuilderDelegate(
//                           (BuildContext context, int index) {
//                             final article =
//                                 articleController.articlesList[index];
//                             return InkWell(
//                               onTap: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (_) =>
//                                         ArticleScreen(id: article.id!)));
//                               },
//                               child: ProductItem(product: article),
//                             );
//                           },
//                           childCount: articleController.articlesList.length,
//                         ),
//                       );
//                     } else {
//                       return const SliverToBoxAdapter(
//                         child: Center(child: Text('No articles found')),
//                       );
//                     }
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_ngrk/core/utils/text_style.dart';
import 'package:flutter_application_ngrk/presentation/controllers/article_controller.dart';
import 'package:flutter_application_ngrk/presentation/screens/product_screen.dart';
import 'package:flutter_application_ngrk/presentation/widgets/input_search.dart';
import 'package:flutter_application_ngrk/presentation/widgets/product_item.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ArticleController articleController = Get.put(ArticleController());

    // Charger les articles une seule fois lors de la création
    articleController.getAllArticles();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InputSearch(
                    onChanged: (query) {
                      articleController.filterArticles(query);
                    },
                  ),
                ),
              ),
            ),
            expandedHeight: MediaQuery.sizeOf(context).height * 0.17,
            floating: true,
            snap: true,
            shadowColor: Colors.black,
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Products',
                style: ConstTextStyle.smallTitleTextStyle,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: GetBuilder<ArticleController>(
              builder: (controller) {
                if (controller.articlesList.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text('No articles found'),
                      ),
                    ),
                  );
                }

                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final article = controller.articlesList[index];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ArticleScreen(id: article.id!),
                          ));
                        },
                        child: ProductItem(product: article),
                      );
                    },
                    childCount: controller.articlesList.length,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
