import 'package:flutter_application_ngrk/data/models/article_model.dart';
import 'package:get/get.dart';
import 'package:flutter_application_ngrk/di.dart';
import 'package:flutter_application_ngrk/domain/entities/article.dart';
import 'package:flutter_application_ngrk/domain/usecases/article_usecase/get_all_articles.dart';
import 'package:flutter_application_ngrk/domain/usecases/article_usecase/get_article_by_id.dart';
import 'package:flutter_application_ngrk/domain/usecases/article_usecase/create_article.dart';
import 'package:flutter_application_ngrk/domain/usecases/article_usecase/update_article.dart';
import 'package:flutter_application_ngrk/domain/usecases/article_usecase/delete_article.dart';

class ArticleController extends GetxController {
  List<Article> allArticles = [];
  List<Article> articlesList = [];

  Future<bool> getAllArticles() async {
    try {
      final result = await GetAllArticles(sl())();
      articlesList = result;
      allArticles = result;
      return true;
    } catch (e) {
      print('Error getting articles: $e');
      return false;
    }
  }

  Future<Article?> getArticleById(int id) async {
    try {
      final result = await GetArticleById(sl())(id);
      return result;
    } catch (e) {
      print('Error getting article by id: $e');
      return null;
    }
  }

  // Future<bool> createArticle(Article article) async {
  //   try {
  //     await CreateArticle(sl())(article);
  //     await getAllArticles();
  //     return true;
  //   } catch (e) {
  //     print('Error creating article: $e');
  //     return false;
  //   }
  // }

  Future<bool> updateArticle(ArticleModel article) async {
    try {
      await UpdateArticle(sl())(article);
      await getAllArticles();
      return true;
    } catch (e) {
      print('Error updating article: $e');
      return false;
    }
  }

  Future<bool> deleteArticle(int id) async {
    try {
      await DeleteArticle(sl())(id);
      await getAllArticles();
      return true;
    } catch (e) {
      print('Error deleting article: $e');
      return false;
    }
  }

  /// Filter articles by name
  void filterArticles(String query) {
    if (query.isEmpty) {
      articlesList = [...allArticles];
    } else {
      articlesList = allArticles
          .where((article) =>
              article.nom.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }
}
