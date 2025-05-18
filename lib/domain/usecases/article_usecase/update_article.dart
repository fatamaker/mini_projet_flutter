// domain/usecases/update_article.dart
import 'package:flutter_application_ngrk/data/models/article_model.dart';
import 'package:flutter_application_ngrk/domain/entities/article.dart';
import 'package:flutter_application_ngrk/domain/repository/article_repository.dart';

class UpdateArticle {
  final ArticleRepository repository;

  UpdateArticle(this.repository);

  Future<void> call(ArticleModel article) async {
    return await repository.updateArticle(article);
  }
}
