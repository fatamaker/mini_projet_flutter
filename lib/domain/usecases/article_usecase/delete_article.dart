// domain/usecases/delete_article.dart

import 'package:flutter_application_ngrk/domain/repository/article_repository.dart';

class DeleteArticle {
  final ArticleRepository repository;

  DeleteArticle(this.repository);

  Future<void> call(int id) async {
    return await repository.deleteArticle(id);
  }
}
