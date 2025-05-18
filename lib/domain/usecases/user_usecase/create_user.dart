import 'package:flutter_application_ngrk/data/models/UserModel.dart';
import 'package:flutter_application_ngrk/domain/repository/user_repository.dart';

import '../../entities/user.dart';

class CreateUser {
  final UserRepository repository;

  CreateUser(this.repository);

  Future<void> call(UserModel user) async {
    return await repository.addUser(user);
  }
}
