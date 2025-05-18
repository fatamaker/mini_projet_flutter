import 'package:flutter_application_ngrk/data/data_source/remote_data_source/user_remote_datasource.dart';
import 'package:flutter_application_ngrk/data/models/UserModel.dart';
import 'package:flutter_application_ngrk/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<UserModel>> getUsers() => remoteDataSource.getUsers();

  @override
  Future<UserModel> getUserById(int id) => remoteDataSource.getUserById(id);

  @override
  Future<void> addUser(UserModel user) => remoteDataSource.addUser(user);

  @override
  Future<void> updateUser(UserModel user) => remoteDataSource.updateUser(user);

  @override
  Future<void> deleteUser(int id) => remoteDataSource.deleteUser(id);

  @override
  Future<UserModel> login(String email, String password) =>
      remoteDataSource.login(email, password);
}
