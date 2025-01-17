import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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
  List<String> bearingTypes = ["Radial", "Spherical", "Thrust"];

  Future<void> loadAllChocks() async {
    emit(ChocksLoadingState());
    try {
      chocks = await chockRepo.getAllChocks();
      emit(ChocksLoadedSuccessfullyState(chocks: chocks));
    } catch (e) {
      emit(ChocksLoadedFailedState(error: e.toString()));
    }
  }

  List<TextEditingController> descControllers = [];
  List<TextEditingController> notesControllers = [];
  List<ImagePicker> pickers = [];
  List<File> imagesPathes = [];

  addField() {
    descControllers.add(TextEditingController());
    notesControllers.add(TextEditingController());
    pickers.add(ImagePicker());
    // imageFiles.add();
    emit(ChockAddFieldsAddedState());
  }

  void addImage(File imageFile) {
    imagesPathes.add(imageFile);
    emit(ChockImageChangedState());
  }

  void removeImage(File image) {
    imagesPathes.remove(image);
    emit(ChockImageChangedState());
  }

  removeField(int index) {
    // if (descControllers.contains(descControllers[index])) {
    descControllers.removeAt(index);
    notesControllers.removeAt(index);
    pickers.removeAt(index);
    emit(ChockAddFieldsRemovedState());
    // } else {
    //   emit(ChockAddFieldsRemovedState());
    // }
  }

  changeImage() {
    emit(ChockImageChangedState());
  }

  getFieldsValue() {}

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
