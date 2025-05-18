import 'package:flutter_application_ngrk/data/models/UserModel.dart';
import 'package:get/get.dart';
import 'package:flutter_application_ngrk/di.dart';
import 'package:flutter_application_ngrk/domain/entities/user.dart';

import 'package:flutter_application_ngrk/domain/usecases/user_usecase/get_all_users.dart';
import 'package:flutter_application_ngrk/domain/usecases/user_usecase/get_user_by_id.dart';
import 'package:flutter_application_ngrk/domain/usecases/user_usecase/create_user.dart';
import 'package:flutter_application_ngrk/domain/usecases/user_usecase/update_user.dart';
import 'package:flutter_application_ngrk/domain/usecases/user_usecase/delete_user.dart';
import 'package:flutter_application_ngrk/domain/usecases/user_usecase/login_user.dart';

class UserController extends GetxController {
  List<UserModel> allUsers = [];
  List<UserModel> usersList = [];

  UserModel? selectedUser;

  // Future<void> getUserById1(int id) async {
  //   // Fetch from remote or local DB
  //   selectedUser = await GetUserById(sl())(id);
  //   update(); // Notify UI
  // }

  Future<bool> getAllUsers() async {
    try {
      final result = await GetAllUsers(sl())();
      usersList = result;
      allUsers = result;
      return true;
    } catch (e) {
      print('Error getting users: $e');
      return false;
    }
  }

  Future<UserModel?> getUserById(int id) async {
    try {
      final result = await GetUserById(sl())(id);
      selectedUser = await GetUserById(sl())(id);
      return result;
    } catch (e) {
      print('Error getting user by id: $e');
      return null;
    }
  }

  Future<bool> createUser(UserModel user) async {
    try {
      await CreateUser(sl())(user);
      await getAllUsers();
      return true;
    } catch (e) {
      print('Error creating user: $e');
      return false;
    }
  }

  Future<bool> updateUser(UserModel user) async {
    try {
      await UpdateUser(sl())(user);
      await getAllUsers();
      return true;
    } catch (e) {
      print('Error updating user: $e');
      return false;
    }
  }

  Future<bool> deleteUser(int id) async {
    try {
      await DeleteUser(sl())(id);
      await getAllUsers();
      return true;
    } catch (e) {
      print('Error deleting user: $e');
      return false;
    }
  }

  Future<UserModel?> loginUser(String email, String password) async {
    try {
      final result = await LoginUser(sl())(email, password);
      return result;
    } catch (e) {
      print('Login failed: $e');
      return null;
    }
  }

  void searchUsers(String query) {
    if (query.isEmpty) {
      usersList = allUsers;
    } else {
      usersList = allUsers.where((user) {
        final lowerQuery = query.toLowerCase();
        return user.nameUser.toLowerCase().contains(lowerQuery) ||
            user.emailUser.toLowerCase().contains(lowerQuery);
      }).toList();
    }
    update();
  }
}
