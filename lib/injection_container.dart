import 'package:get_it/get_it.dart';
import 'package:rollshop/features/assembly_steps_feature/view_model/chock_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - chock-types
  // Cubit
  sl.registerFactory<ChockCubit>(() => ChockCubit(sl()));
}
