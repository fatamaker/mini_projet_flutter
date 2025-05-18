// data/repositories/article_repository_impl.dart
import 'package:flutter_application_ngrk/data/data_source/remote_data_source/article_remote_datasource.dart';
import 'package:flutter_application_ngrk/data/models/article_model.dart';
import 'package:flutter_application_ngrk/domain/entities/article.dart';
import 'package:flutter_application_ngrk/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteDataSource;

  ArticleRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Article>> getArticles() async {
    return await remoteDataSource.getArticles();
  }

  @override
  Future<Article> getArticleById(int id) async {
    return await remoteDataSource.getArticleById(id);
  }

  @override
  Future<void> createArticle(ArticleModel article) async {
    return await remoteDataSource.addArticle(article);
  }

  @override
  Future<void> updateArticle(ArticleModel article) async {
    return await remoteDataSource.updateArticle(article);
  }

  @override
  Future<void> deleteArticle(int id) async {
    return await remoteDataSource.deleteArticle(id);
  }
}
