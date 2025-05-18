import 'package:flutter_application_ngrk/data/models/UserModel.dart';
import 'package:flutter_application_ngrk/domain/repository/user_repository.dart';

import '../../entities/user.dart';

class GetAllUsers {
  final UserRepository repository;

  GetAllUsers(this.repository);

  Future<List<UserModel>> call() async {
    return await repository.getUsers();
  }
}
