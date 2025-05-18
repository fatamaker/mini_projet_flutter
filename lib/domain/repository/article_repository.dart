// domain/repositories/article_repository.dart
import 'package:flutter_application_ngrk/data/models/article_model.dart';
import 'package:flutter_application_ngrk/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<List<Article>> getArticles();
  Future<Article> getArticleById(int id);
  Future<void> createArticle(ArticleModel article);
  Future<void> updateArticle(ArticleModel article);
  Future<void> deleteArticle(int id);
}
