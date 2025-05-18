import 'package:flutter_application_ngrk/data/models/UserModel.dart';
import 'package:flutter_application_ngrk/domain/repository/user_repository.dart';

import '../../entities/user.dart';

class GetUserById {
  final UserRepository repository;

  GetUserById(this.repository);

  Future<UserModel> call(int id) async {
    return await repository.getUserById(id);
  }
}
