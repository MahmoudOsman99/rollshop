import 'package:get_it/get_it.dart';
import 'package:rollshop/features/auth/cubit/auth_cubit.dart';
import 'package:rollshop/features/auth/model/data/remote/user_remote.dart';
import 'package:rollshop/features/auth/model/repository/user_repository.dart';
import 'package:rollshop/features/auth/model/repository/user_repository_impl.dart';
import 'package:rollshop/features/chock_feature/models/data/remote/remote_data_source.dart';
import 'package:rollshop/features/chock_feature/models/repository/chock_repository.dart';
import 'package:rollshop/features/chock_feature/models/repository/chock_repository_imp.dart';
import 'package:rollshop/features/chock_feature/cubit/chock_cubit.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';
import 'package:rollshop/features/parts_with_material_number/model/data/remote/parts_remote_data_source.dart';
import 'package:rollshop/features/parts_with_material_number/model/data/repository/parts_repo_implment.dart';
import 'package:rollshop/features/parts_with_material_number/model/data/repository/parts_repository.dart';
import 'package:rollshop/features/parts_with_material_number/cubit/parts_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! App Cubit
  // Cubit
  sl.registerLazySingleton<AppCubit>(() => AppCubit());

  //! Auth Cubit
  // Remote
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(userRemote: sl()),
  );
  sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSource());
  // Cubit
  sl.registerLazySingleton<AuthCubit>(() => AuthCubit(userRepo: sl()));

  //! Features - chock-types
  // Remote
  sl.registerLazySingleton<ChockRemoteDataSource>(
    () => ChockRemoteDataSource(),
  );
  sl.registerLazySingleton<ChockRepository>(
    () => ChockRepositoryImp(remote: sl()),
  );
  // Cubit
  sl.registerLazySingleton<ChockCubit>(() => ChockCubit(chockRepo: sl()));

  //! Features - parts

  // Repository
  sl.registerLazySingleton<PartsRepository>(
      () => PartsRepoImplment(partsRemoteDataSource: sl()));

  // Remote
  sl.registerLazySingleton<PartsRemoteDataSource>(
      () => PartsRemoteDataSource());

  // Cubit
  sl.registerLazySingleton<PartsCubit>(() => PartsCubit(
        sl<PartsRepository>(),
      ));
}
