// import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import '../../features/auth/data/datasources/auth_remote_data_source.dart';
// import '../../features/auth/data/repositories/auth_repository_impl.dart';
// import '../../features/auth/domain/repositories/auth_repository.dart';
// import '../../features/auth/domain/usecases/login.dart';
// import '../../features/auth/presentation/bloc/auth_bloc.dart';

// final sl = GetIt.instance;

// Future<void> init() async {
//   // Bloc
//   sl.registerFactory(() => AuthBloc(sl()));

//   // Use cases
//   sl.registerLazySingleton(() => Login(sl()));

//   // Repository
//   sl.registerLazySingleton<AuthRepository>(
//       () => AuthRepositoryImpl(remoteDataSource: sl()));

//   // Data sources
//   sl.registerLazySingleton<AuthDataSource>(
//       () => AuthRemoteDataSource(client: sl()));
 

//   // External
//   sl.registerLazySingleton(() => Dio());
// }
import 'package:get_it/get_it.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hummraah/core/services/api_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => AuthBloc(sl()));

  // Use cases
  sl.registerLazySingleton(() => Login(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // // Data sources
  // sl.registerLazySingleton<AuthDataSource>(() => AuthRemoteDataSource(sl()));

  // Api Service
  sl.registerLazySingleton(() => ApiService());
  // Data sources
  sl.registerLazySingleton<AuthDataSource>(() => AuthRemoteDataSource(sl()));
}
