import 'package:flutter_application_ngrk/data/models/UserModel.dart';

abstract class UserRepository {
  Future<List<UserModel>> getUsers();
  Future<UserModel> getUserById(int id);
  Future<void> addUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser(int id);
  Future<UserModel> login(String email, String password);
}
