import 'package:flutter/material.dart';
import 'package:flutter_application_ngrk/data/models/UserModel.dart';
import 'package:flutter_application_ngrk/presentation/controllers/user_controller.dart';
import 'package:get/get.dart';

class EditUserScreen extends StatefulWidget {
  final int userId;

  const EditUserScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserController userController = Get.find<UserController>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _roleController;
  late TextEditingController _addressController;

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    userController.getUserById(widget.userId).then((_) {
      final user = userController.selectedUser;
      if (user != null) {
        _nameController = TextEditingController(text: user.nameUser);
        _emailController = TextEditingController(text: user.emailUser);
        _phoneController = TextEditingController(text: user.password);
        _roleController = TextEditingController(text: user.role);
        _addressController = TextEditingController(text: user.adresseUser);

        setState(() {
          _isInitialized = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _roleController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromARGB(255, 223, 174, 12)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit User",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: !_isInitialized
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: _buildInputDecoration("Name"),
                      validator: (value) =>
                          value!.isEmpty ? 'Name is required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: _buildInputDecoration("Email"),
                      validator: (value) =>
                          value!.isEmpty ? 'Email is required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _addressController,
                      decoration: _buildInputDecoration("Address"),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _roleController,
                      decoration: _buildInputDecoration("Role"),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      decoration: _buildInputDecoration("Password"),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final updatedUser = UserModel(
                            idUser: widget.userId,
                            nameUser: _nameController.text,
                            emailUser: _emailController.text,
                            adresseUser: _addressController.text,
                            role: _roleController.text,
                            password: _phoneController.text,
                          );

                          final success =
                              await userController.updateUser(updatedUser);

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(success ? "Confirmation" : "Error"),
                              content: Text(success
                                  ? "The user has been updated successfully."
                                  : "Failed to update user."),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text("OK"),
                                )
                              ],
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 223, 174, 12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        "Save Changes",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_application_ngrk/data/models/UserModel.dart';
// import 'package:flutter_application_ngrk/presentation/controllers/user_controller.dart';
// import 'package:get/get.dart';

// class EditUserScreen extends StatefulWidget {
//   final int userId;

//   const EditUserScreen({Key? key, required this.userId}) : super(key: key);

//   @override
//   _EditUserScreenState createState() => _EditUserScreenState();
// }

// class _EditUserScreenState extends State<EditUserScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final UserController userController = Get.find<UserController>();

//   late TextEditingController _nameController;
//   late TextEditingController _emailController;
//   late TextEditingController _phoneController;
//   late TextEditingController _roleController;
//   late TextEditingController _addressController;

//   bool _isInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     userController.getUserById(widget.userId).then((_) {
//       final user = userController.selectedUser;
//       if (user != null) {
//         _nameController = TextEditingController(text: user.nameUser);
//         _emailController = TextEditingController(text: user.emailUser);
//         _phoneController = TextEditingController(text: user.password);
//         _roleController = TextEditingController(text: user.role);
//         _addressController = TextEditingController(text: user.adresseUser);

//         setState(() {
//           _isInitialized = true;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _roleController.dispose();
//     _addressController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:
//           AppBar(title: const Text("Edit User"), backgroundColor: Colors.green),
//       body: !_isInitialized
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: ListView(
//                   children: [
//                     TextFormField(
//                       controller: _nameController,
//                       decoration: const InputDecoration(labelText: "Name"),
//                       validator: (value) =>
//                           value!.isEmpty ? 'Required field' : null,
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: _emailController,
//                       decoration: const InputDecoration(labelText: "Email"),
//                       validator: (value) =>
//                           value!.isEmpty ? 'Required field' : null,
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: _addressController,
//                       decoration: const InputDecoration(labelText: "Address"),
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: _roleController,
//                       decoration: const InputDecoration(labelText: "Role"),
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: _phoneController,
//                       decoration: const InputDecoration(labelText: "Password"),
//                     ),
//                     const SizedBox(height: 30),
//                     ElevatedButton(
//                       onPressed: () async {
//                         if (_formKey.currentState!.validate()) {
//                           final updatedUser = UserModel(
//                             idUser: widget.userId,
//                             nameUser: _nameController.text,
//                             emailUser: _emailController.text,
//                             adresseUser: _addressController.text,
//                             role: _roleController.text,
//                             password: _phoneController.text,
//                           );

//                           final success =
//                               await userController.updateUser(updatedUser);

//                           showDialog(
//                             context: context,
//                             builder: (context) => AlertDialog(
//                               title: Text(success ? "Confirmation" : "Error"),
//                               content: Text(success
//                                   ? "The user has been updated successfully."
//                                   : "Failed to update user."),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () => Navigator.of(context).pop(),
//                                   child: const Text("OK"),
//                                 )
//                               ],
//                             ),
//                           );
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 32, vertical: 14),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                         elevation: 4,
//                       ),
//                       child: const Text(
//                         "Save Changes",
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
