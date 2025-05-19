// domain/entities/article.dart
import 'package:flutter/src/widgets/framework.dart';

class Article {
  final int id;
  final String nom;
  final String description;
  final String image;
  final int prix;
  final int stock;

  const Article({
    required this.id,
    required this.nom,
    required this.description,
    required this.image,
    required this.prix,
    required this.stock,
  });
}
