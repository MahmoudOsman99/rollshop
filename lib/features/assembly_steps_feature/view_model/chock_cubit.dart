import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollshop/features/assembly_steps_feature/models/assembly_steps_model.dart';
import 'package:rollshop/features/assembly_steps_feature/models/chock_type_model.dart';
import 'package:rollshop/features/assembly_steps_feature/models/data/remote_data_source.dart';

import 'chock_state.dart';

class ChockCubit extends Cubit<ChocksState> {
  ChockCubit(super.initialState);

  // Future<List<ChockTypesModel>> loadAllChocks() async {
  //   emit(state.copyWith(status: ChockStatus.loading));
  //   try {} catch (e) {
  //     emit(state.copyWith(
  //         status: ChockStatus.failure, errorMessage: e.toString()));
  //   }
  // }

  void addOneChock(ChockTypesModel newChock) {
    // Create a new list with the added chock
    ChockRemoteDataSource().addChock(
      ChockTypesModel(
        name: "BDM Bottom Chock",
        chockImagePath: "assets/images/chock_types/bds.jpg",
        notes: "efefefefef",
        assemblySteps: [
          AssemblyStepsModel(
            description: description,
            stepsDetailes: stepsDetailes,
            notes: notes,
          ),
        ],
      ),
    );
    emit(ChockAddedSuccessfullyState());
  }
}
