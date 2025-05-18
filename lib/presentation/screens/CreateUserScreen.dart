import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_ngrk/data/models/UserModel.dart';
import 'package:flutter_application_ngrk/presentation/controllers/user_controller.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  String selectedRole = 'user';

  final userController = Get.find<UserController>();

  void submitUser() async {
    if (_formKey.currentState!.validate()) {
      final user = UserModel(
        idUser: 0,
        nameUser: nameController.text.trim(),
        emailUser: emailController.text.trim(),
        adresseUser: addressController.text.trim(),
        role: selectedRole,
        password: passwordController.text.trim(),
      );

      final success = await userController.createUser(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Créer un utilisateur")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    "Formulaire de Création ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Nom complet'),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Entrez un nom' : null,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) => value != null && value.contains('@')
                        ? null
                        : 'Email invalide',
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'Adresse'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Entrez une adresse'
                        : null,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: passwordController,
                    decoration:
                        const InputDecoration(labelText: 'Mot de passe'),
                    obscureText: true,
                    validator: (value) => value != null && value.length >= 6
                        ? null
                        : 'Min. 6 caractères',
                  ),
                  const SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    value: selectedRole,
                    items: ['user', 'admin']
                        .map((role) => DropdownMenuItem(
                              value: role,
                              child: Text(role.toUpperCase()),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedRole = value;
                        });
                      }
                    },
                    decoration: const InputDecoration(labelText: 'Rôle'),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton.icon(
                    onPressed: submitUser,
                    icon: const Icon(Icons.save),
                    label: const Text("Créer l'utilisateur"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
