import 'package:flutter_application_ngrk/data/data_source/remote_data_source/article_remote_datasource.dart';
import 'package:flutter_application_ngrk/data/data_source/remote_data_source/order_remote_datasource.dart';
import 'package:flutter_application_ngrk/data/data_source/remote_data_source/user_remote_datasource.dart';
import 'package:flutter_application_ngrk/data/repository/article_repository_impl.dart';
import 'package:flutter_application_ngrk/data/repository/order_repository_impl.dart';
import 'package:flutter_application_ngrk/data/repository/user_repository_impl.dart';
import 'package:flutter_application_ngrk/domain/repository/article_repository.dart';
import 'package:flutter_application_ngrk/domain/repository/order_repository.dart';
import 'package:flutter_application_ngrk/domain/repository/user_repository.dart';
import 'package:flutter_application_ngrk/domain/usecases/article_usecase/create_article.dart';
import 'package:flutter_application_ngrk/domain/usecases/article_usecase/delete_article.dart';
import 'package:flutter_application_ngrk/domain/usecases/article_usecase/get_all_articles.dart';
import 'package:flutter_application_ngrk/domain/usecases/article_usecase/get_article_by_id.dart';
import 'package:flutter_application_ngrk/domain/usecases/article_usecase/update_article.dart';
import 'package:flutter_application_ngrk/domain/usecases/order_usecase/UpdateOrderStatusUseCase.dart';
import 'package:flutter_application_ngrk/domain/usecases/order_usecase/create_order.dart';
import 'package:flutter_application_ngrk/domain/usecases/order_usecase/delete_order.dart';
import 'package:flutter_application_ngrk/domain/usecases/order_usecase/get_all_orders.dart';
import 'package:flutter_application_ngrk/domain/usecases/user_usecase/create_user.dart';
import 'package:flutter_application_ngrk/domain/usecases/user_usecase/delete_user.dart';
import 'package:flutter_application_ngrk/domain/usecases/user_usecase/get_all_users.dart';
import 'package:flutter_application_ngrk/domain/usecases/user_usecase/get_user_by_id.dart';
import 'package:flutter_application_ngrk/domain/usecases/user_usecase/login_user.dart';
import 'package:flutter_application_ngrk/domain/usecases/user_usecase/update_user.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // DataSources
  sl.registerLazySingleton<ArticleRemoteDataSource>(
    () => ArticleRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<ArticleRepository>(
    () => ArticleRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(sl()),
  );
  // Usecases

  //Articels
  sl.registerLazySingleton(() => GetAllArticles(sl()));
  sl.registerLazySingleton(() => GetArticleById(sl()));
  sl.registerLazySingleton(() => CreateArticle(sl()));
  sl.registerLazySingleton(() => UpdateArticle(sl()));
  sl.registerLazySingleton(() => DeleteArticle(sl()));

  //Users
  sl.registerLazySingleton(() => GetAllUsers(sl()));
  sl.registerLazySingleton(() => GetUserById(sl()));
  sl.registerLazySingleton(() => CreateUser(sl()));
  sl.registerLazySingleton(() => UpdateUser(sl()));
  sl.registerLazySingleton(() => DeleteUser(sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));

  //order
  sl.registerLazySingleton(() => GetAllOrders(sl()));
  sl.registerLazySingleton(() => DeleteOrder(sl()));
  sl.registerLazySingleton(() => CreateOrder(sl()));
  sl.registerLazySingleton(() => UpdateOrderStatusUseCase(sl()));
}
