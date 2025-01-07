import 'package:get_it/get_it.dart';
import 'package:rollshop/features/assembly_steps_feature/view_model/chock_cubit.dart';
import 'package:rollshop/features/parts_with_material_number/view_model/cubit/parts_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - chock-types
  // Cubit
  sl.registerLazySingleton<ChockCubit>(() => ChockCubit(sl()));
  sl.registerLazySingleton<PartsCubit>(() => PartsCubit(sl()));
}
