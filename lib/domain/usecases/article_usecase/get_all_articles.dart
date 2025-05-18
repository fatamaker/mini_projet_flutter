// domain/usecases/get_all_articles.dart
import 'package:flutter_application_ngrk/domain/entities/article.dart';
import 'package:flutter_application_ngrk/domain/repository/article_repository.dart';

class GetAllArticles {
  final ArticleRepository repository;

  GetAllArticles(this.repository);

  Future<List<Article>> call() async {
    return await repository.getArticles();
  }
}
