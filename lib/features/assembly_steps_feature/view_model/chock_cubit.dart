import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollshop/core/helpers/images_path.dart';
import 'package:rollshop/features/assembly_steps_feature/models/assembly_steps_model.dart';
import 'package:rollshop/features/assembly_steps_feature/models/chock_type_model.dart';
import 'package:rollshop/features/assembly_steps_feature/models/data/remote/remote_data_source.dart';

import 'chock_state.dart';

class ChockCubit extends Cubit<ChockState> {
  ChockCubit(super.initialState);
  static ChockCubit get(context) => BlocProvider.of(context);

  Future<void> loadAllChocks() async {
    emit(ChocksLoadingState());

    final loadedChocks = await ChockRemoteDataSource().getAllChocks();

    emit(ChocksLoadedSuccessfullyState(chocks: loadedChocks));
  }

  void addOneChock({required ChockTypesModel newChock}) {
    // Create a new list with the added chock
    ChockRemoteDataSource().addChock(
      ChockTypesModel(
        name: "Piston",
        chockImagePath: "",
        notes: "notes",
        assemblySteps: [
          AssemblyStepsModel(
            description: "description",
            imagesPath: [""],
            notes: "notes",
          ),
          AssemblyStepsModel(
            description: "الخطوة الاولي",
            imagesPath: [""],
            notes: "notes",
          ),
          AssemblyStepsModel(
            description: "description",
            imagesPath: [""],
            notes: "notes",
          ),
          AssemblyStepsModel(
            description: "description",
            imagesPath: [""],
            notes: "notes",
          ),
        ],
      ),
    );
    emit(ChockAddedSuccessfullyState());
  }
  // void addOneChock({required ChockTypesModel newChock}) {
  //   // Create a new list with the added chock
  //   ChockRemoteDataSource().addChock(newChock);
  //   emit(ChockAddedSuccessfullyState());
  // }

  // void getAllChocks() {
  //   // Create a new list with the added chock
  //   ChockRemoteDataSource().getAllChocks();
  //   emit(ChockAddedSuccessfullyState());
  // }
}
