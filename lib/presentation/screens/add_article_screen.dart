import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/article_model.dart';
import '../controllers/article_controller.dart';

class AddArticleScreen extends StatefulWidget {
  const AddArticleScreen({super.key});

  @override
  State<AddArticleScreen> createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nomController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController prixController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  final ArticleController controller = Get.find<ArticleController>();

  File? selectedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (selectedImage == null) {
        Get.snackbar("Erreur", "Veuillez sélectionner une image.");
        return;
      }

      final newArticle = ArticleModel(
        id: 0,
        nom: nomController.text,
        description: descriptionController.text,
        image: "", // Backend va gérer l'image uploadée
        prix: int.tryParse(prixController.text) ?? 0,
        stock: int.tryParse(stockController.text) ?? 0,
      );

      final success =
          await controller.createArticle(newArticle, selectedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un article')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nomController,
                decoration: const InputDecoration(labelText: 'Nom'),
                validator: (value) =>
                    value!.isEmpty ? 'Veuillez entrer un nom' : null,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) =>
                    value!.isEmpty ? 'Veuillez entrer une description' : null,
              ),
              TextFormField(
                controller: prixController,
                decoration: const InputDecoration(labelText: 'Prix'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Veuillez entrer un prix' : null,
              ),
              TextFormField(
                controller: stockController,
                decoration: const InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Veuillez entrer le stock' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text("Choisir une image"),
              ),
              if (selectedImage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.file(selectedImage!, height: 150),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Créer l\'article'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
