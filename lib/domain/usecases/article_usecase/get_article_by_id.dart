// domain/usecases/get_article_by_id.dart
import 'package:flutter_application_ngrk/domain/entities/article.dart';
import 'package:flutter_application_ngrk/domain/repository/article_repository.dart';

class GetArticleById {
  final ArticleRepository repository;

  GetArticleById(this.repository);

  Future<Article> call(int id) async {
    return await repository.getArticleById(id);
  }
}
