import 'package:flutter/material.dart';
import 'package:flutter_application_ngrk/data/models/UserModel.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const UserCard({
    super.key,
    required this.user,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        title: Text(user.nameUser,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(user.emailUser),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.black),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.black),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
