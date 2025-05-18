// lib/data/datasources/article_remote_datasource.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_ngrk/core/utils/api_const.dart';
import 'package:flutter_application_ngrk/data/models/article_model.dart';

abstract class ArticleRemoteDataSource {
  Future<List<ArticleModel>> getArticles();
  Future<ArticleModel> getArticleById(int id);
  Future<void> addArticle(ArticleModel article);
  Future<void> updateArticle(ArticleModel article);
  Future<void> deleteArticle(int id);
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  @override
  Future<List<ArticleModel>> getArticles() async {
    final uri = Uri.parse(APIConst.Products);
    try {
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => ArticleModel.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load articles. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load articles. Error: $e');
    }
  }

  @override
  Future<ArticleModel> getArticleById(int id) async {
    final uri = Uri.parse('${APIConst.Products}/$id');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return ArticleModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Article not found');
    }
  }

  @override
  Future<void> addArticle(ArticleModel article) async {
    final uri = Uri.parse(APIConst.Products);
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(article.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to create article');
    }
  }

  @override
  Future<void> updateArticle(ArticleModel article) async {
    final uri = Uri.parse('${APIConst.Products}/${article.id}');
    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(article.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update article');
    }
  }

  @override
  Future<void> deleteArticle(int id) async {
    final uri = Uri.parse('${APIConst.Products}/$id');
    final response = await http.delete(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete article');
    }
  }
}
