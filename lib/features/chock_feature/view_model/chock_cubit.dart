import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollshop/features/chock_feature/models/chock_type_model.dart';
import 'package:rollshop/features/chock_feature/models/repository/chock_repository.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';
import 'chock_state.dart';

class ChockCubit extends Cubit<ChockState> {
  ChockCubit({required this.chockRepo}) : super(ChocksInitialState());
  ChockRepository chockRepo;
  // static ChockCubit get(context) => BlocProvider.of(context);
  List<ChockTypesModel> chocks = [];
  // List<PartsWithMaterialNumberModel> parts = [];

  Future<void> loadAllChocks() async {
    emit(ChocksLoadingState());
    try {
      chocks = await chockRepo.getAllChocks();
      emit(ChocksLoadedSuccessfullyState(chocks: chocks));
    } catch (e) {
      emit(ChocksLoadedFailedState(error: e.toString()));
    }
  }

  // Future<void> getAllParts() async {
  //   emit(ChocksLoadingState());
  //   try {
  //     chocks = await chockRepo.getAllChocks();
  //     emit(ChocksLoadedSuccessfullyState(chocks: chocks));
  //   } catch (e) {
  //     emit(ChocksLoadedFailedState(error: e.toString()));
  //   }
  // }

  void addOneChock({required ChockTypesModel newChock}) {
    // Create a new list with the added chock
    // ChockRemoteDataSource().addChock(
    //   ChockTypesModel(
    //     name: "Piston",
    //     chockImagePath: "",
    //     notes: "notes",
    //     assemblySteps: [
    //       AssemblyStepsModel(
    //         description: "description",
    //         imagesPath: [""],
    //         notes: "notes",
    //       ),
    //       AssemblyStepsModel(
    //         description: "الخطوة الاولي",
    //         imagesPath: [""],
    //         notes: "notes",
    //       ),
    //       AssemblyStepsModel(
    //         description: "description",
    //         imagesPath: [""],
    //         notes: "notes",
    //       ),
    //       AssemblyStepsModel(
    //         description: "description",
    //         imagesPath: [""],
    //         notes: "notes",
    //       ),
    //     ],
    //   ),
    // );
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
