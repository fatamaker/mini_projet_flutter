import 'package:flutter_application_ngrk/data/models/UserModel.dart';
import 'package:flutter_application_ngrk/domain/repository/user_repository.dart';

class UpdateUser {
  final UserRepository repository;

  UpdateUser(this.repository);

  Future<void> call(UserModel user) async {
    return await repository.updateUser(user);
  }
}
