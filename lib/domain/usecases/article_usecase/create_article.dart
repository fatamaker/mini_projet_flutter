// domain/usecases/create_article.dart
import 'dart:io';

import 'package:flutter_application_ngrk/data/models/article_model.dart';
import 'package:flutter_application_ngrk/domain/entities/article.dart';
import 'package:flutter_application_ngrk/domain/repository/article_repository.dart';

class CreateArticle {
  final ArticleRepository repository;

  CreateArticle(this.repository);

  Future<void> call(ArticleModel article, File imageFile) {
    return repository.createArticle(article, imageFile);
  }
}
