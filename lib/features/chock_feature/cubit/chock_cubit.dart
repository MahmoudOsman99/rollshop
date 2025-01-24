import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rollshop/core/helpers/image_handler.dart';
import 'package:rollshop/features/chock_feature/models/assembly_steps_model.dart';
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

  Future<void> getAllChocks() async {
    emit(ChocksLoadingState());
    try {
      chocks = await chockRepo.getAllChocks();
      emit(ChocksLoadedSuccessfullyState(chocks: chocks));
    } catch (e) {
      emit(ChocksLoadedFailedState(error: e.toString()));
    }
  }

  List<PartsWithMaterialNumberModel> selectedParts = [];

  List<TextEditingController> descControllers = [];
  List<TextEditingController> notesControllers = [];

  ///this list to get the values that inside the list of controllers
  List<String> allDescriptionControllersValues = [];
  List<String> allNotesControllersValues = [];
  List<ImagePicker> pickers = [];
  List<File> imagesPathes = [];

  addField() {
    descControllers.add(TextEditingController());
    notesControllers.add(TextEditingController());
    pickers.add(ImagePicker());
    // imageFiles.add();
    // emit(ChockAddFieldsAddedState());
  }

  void addImage(File imageFile, int index) {
    // if(imagesPathes.contains(imagesPathes[index]))
    if (index == imagesPathes.length) {
      imagesPathes.add(imageFile);
      return;
    }
    imagesPathes[index] = imageFile;
    // imagesPathes.add(imageFile);
    // emit(ChockImageChangedState());
  }

  void removeImage(int index) {
    try {
      debugPrint("${imagesPathes.length.toString()} before delete image");
      if (imagesPathes.isNotEmpty) {
        if (imagesPathes[index] != null) {
          imagesPathes.removeAt(index);
        }
      }
      debugPrint("${imagesPathes.length.toString()} after delete image");
      // pickers.removeAt(index);
      // emit(ChockImageChangedState());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  List<String> uploadImagesToImgurAndGetImagesUrls(List<File> imagesFiles) {
    emit(ChocksLoadingState());
    final List<String> imagesUrls = [];
    imagesFiles.map((file) async {
      if (file.path != null && file.path.isNotEmpty) {
        String? imageUrl = await ImageHandler().uploadImageToImgur(file);
        if (imageUrl != null) imagesUrls.add(imageUrl);
      }
    });
    emit(ChocksAssemblyStepsUploadedSuccessfullyState(imagesUrls: imagesUrls));
    return imagesUrls;
  }

  removeField(int index) {
    // if (descControllers.contains(descControllers[index])) {
    if (index >= 0 && index < descControllers.length) {
      descControllers[index].dispose();
      notesControllers[index].dispose();

      descControllers.removeAt(index);
      notesControllers.removeAt(index);
      pickers.removeAt(index);
      if (imagesPathes.length > index) {
        imagesPathes.removeAt(index);
      }
    }
    // emit(ChockAddFieldsRemovedState());
    // } else {
    //   emit(ChockAddFieldsRemovedState());
    // }
  }

  changeImage(int index, File imageFile) {
    if (index == imagesPathes.length) {
      return;
    }
    imagesPathes[index] = imageFile;
    // emit(ChockImageChangedState());
  }

  getFieldsValue() {
    for (var controller in descControllers) {
      allDescriptionControllersValues.add(controller.text);
    }
    for (var controller in notesControllers) {
      allNotesControllersValues.add(controller.text);
    }
  }

  saveChockDetailes({
    required String name,
    required String bearingType,
    required File chockImagePath,
    required String notes,
    required String howTocalcBearingShim,

    // required String notes,
  }) async {
    emit(ChocksLoadingState());
    getFieldsValue();
    // try {
    List<AssemblyStepModel> stepsModel = [];
    for (int i = 0; i < descControllers.length; i++) {
      stepsModel.add(
        AssemblyStepModel(
            description: allDescriptionControllersValues[i],
            imagePath:
                await ImageHandler().uploadImageToImgur(imagesPathes[i]) ?? "",
            notes: allNotesControllersValues[i]),
      );
    }
    // List<PartsWithMaterialNumberModel> selectedParts = [];
    // for (int i = 0; i < descControllers.length; i++) {
    //   stepsModel.add(
    //     AssemblyStepModel(
    //         description: allDescriptionControllersValues[i],
    //         imagePath:
    //             await ImageHandler().uploadImageToImgur(imagesPathes[i]) ?? "",
    //         notes: allNotesControllersValues[i]),
    //   );
    // }

    chockRepo.addChock(
      chock: ChockTypesModel(
        bearingType: bearingType,
        name: name,
        chockImagePath:
            await ImageHandler().uploadImageToImgur(chockImagePath) ?? "",
        notes: notes,
        howTocalcBearingShim: howTocalcBearingShim,
        parts: selectedParts,
        assemblySteps: stepsModel,
      ),
    );
    getAllChocks();
    // emit(ChockAddedSuccessfullyState());

    // } catch (e) {
    //   debugPrint(e.toString());
    // }
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
