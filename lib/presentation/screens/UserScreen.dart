import 'package:flutter/material.dart';

import 'package:flutter_application_ngrk/presentation/controllers/user_controller.dart';

import 'package:flutter_application_ngrk/presentation/screens/CreateUserScreen.dart';
import 'package:flutter_application_ngrk/presentation/screens/EditUserScreen.dart';
import 'package:get/get.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final UserController controller = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    controller.getAllUsers().then((_) {
      controller.update(); // met à jour GetBuilder
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des utilisateurs",
            style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher par nom ou email...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (query) {
                controller.searchUsers(query);
              },
            ),
          ),
          Expanded(
            child: GetBuilder<UserController>(
              builder: (controller) {
                final users = controller.usersList;

                if (users.isEmpty) {
                  return const Center(child: Text("Aucun utilisateur trouvé."));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.nameUser,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user.emailUser,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => EditUserScreen(
                                                userId: user.idUser)));
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () async {
                                    await controller.deleteUser(user.idUser);
                                    controller.update();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => CreateUserScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
