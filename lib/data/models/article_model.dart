import '../../domain/entities/article.dart';

class ArticleModel extends Article {
  const ArticleModel({
    required super.id,
    required super.nom,
    required super.description,
    required super.image,
    required super.prix,
    required super.stock,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      nom: json['nom'],
      description: json['description'],
      image: json['image'],
      prix: json['prix'],
      stock: json['stock'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'description': description,
      'image': image,
      'prix': prix,
      'stock': stock,
    };
  }
}
