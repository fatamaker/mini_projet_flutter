import 'dart:convert';
import 'package:flutter_application_ngrk/core/utils/api_const.dart';
import 'package:flutter_application_ngrk/data/models/UserModel.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
  Future<UserModel> getUserById(int id);
  Future<void> addUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser(int id);
  Future<UserModel> login(String email, String password);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final headers = {'Content-Type': 'application/json'};

  @override
  Future<List<UserModel>> getUsers() async {
    final uri = Uri.parse(APIConst.Users);
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Future<UserModel> getUserById(int id) async {
    final uri = Uri.parse('${APIConst.Users}/$id');
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('User not found');
    }
  }

  @override
  Future<void> addUser(UserModel user) async {
    final uri = Uri.parse(APIConst.Users);
    final response = await http.post(uri,
        headers: headers, body: json.encode(user.toJson()));
    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Failed to create user');
    }
  }

  @override
  Future<void> updateUser(UserModel user) async {
    final uri = Uri.parse('${APIConst.Users}/${user.idUser}');
    final response =
        await http.put(uri, headers: headers, body: json.encode(user.toJson()));
    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }

  @override
  Future<void> deleteUser(int id) async {
    final uri = Uri.parse('${APIConst.Users}/$id');
    final response = await http.delete(uri, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }

  @override
  Future<UserModel> login(String email, String password) async {
    final uri = Uri.parse('${APIConst.Users}/login');
    final response = await http.post(uri,
        headers: headers,
        body: json.encode({"email": email, "password": password}));
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Login failed');
    }
  }
}
