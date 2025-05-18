import 'package:flutter_application_ngrk/data/models/UserModel.dart';
import 'package:flutter_application_ngrk/domain/repository/user_repository.dart';

class LoginUser {
  final UserRepository repository;

  LoginUser(this.repository);

  Future<UserModel> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
