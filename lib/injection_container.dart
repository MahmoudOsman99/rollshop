import 'package:get_it/get_it.dart';
import 'package:rollshop/features/assembly_steps_feature/view_model/chock_cubit.dart';
import 'package:rollshop/features/parts_with_material_number/model/data/remote/parts_remote_data_source.dart';
import 'package:rollshop/features/parts_with_material_number/model/data/repository/parts_repo_implment.dart';
import 'package:rollshop/features/parts_with_material_number/model/data/repository/parts_repository.dart';
import 'package:rollshop/features/parts_with_material_number/view_model/cubit/parts_cubit.dart';
import 'package:rollshop/features/parts_with_material_number/view_model/cubit/parts_state.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - chock-types
  // Cubit
  sl.registerLazySingleton<ChockCubit>(() => ChockCubit(sl()));

  //! Features - parts
  // Cubit
  sl.registerLazySingleton<PartsCubit>(
      () => PartsCubit(sl(), partsRepository: sl()));
  sl.registerLazySingleton<PartsState>(() => PartsInitialState());

  // Repository
  sl.registerLazySingleton<PartsRepository>(
      () => PartsRepoImplment(partsRemoteDataSource: sl()));

  // Remote
  sl.registerLazySingleton<PartsRemoteDataSource>(
      () => PartsRemoteDataSource());
}
