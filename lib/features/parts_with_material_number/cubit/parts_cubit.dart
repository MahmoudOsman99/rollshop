import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollshop/core/router/app_router.dart';
import 'package:rollshop/features/parts_with_material_number/model/data/repository/parts_repository.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';
import 'package:rollshop/features/parts_with_material_number/cubit/parts_state.dart';

class PartsCubit extends Cubit<PartsState> {
  // PartsWithMaterialNumberViewModel partViewModel;
  PartsRepository partsRepository = sl<PartsRepository>();
  PartsCubit(this.partsRepository) : super(PartsInitialState());

  // static PartsCubit get(context) => BlocProvider.of(context);
  List<PartsWithMaterialNumberModel> parts = [];
  bool allowEdit = false;
  changeAllowEdit() {
    allowEdit = !allowEdit;
    emit(PartChangeAllowEditState(allowEdit: allowEdit));
  }

  Future<void> getAllParts() async {
    if (isClosed) return;
    // parts = [];
    emit(PartsLoadingState());
    parts = await partsRepository.getParts();
    emit(PartsLoadedSuccessfullyState(parts: parts));
  }

  deletePart({required String id}) async {
    if (isClosed) return;
    debugPrint(id);
    parts.removeWhere(
      (element) => element.id == id,
    );

    await partsRepository.deletePart(id: id);
    // emit(PartDeletedSuccessfullyState());
    getAllParts();
  }

  Future<bool> addOnePart({required PartsWithMaterialNumberModel part}) async {
    // if (isClosed) return;
    emit(PartWatingState());
    if (await isPartExistByMaterialNumber(
        materialNumber: part.materialNumber)) {
      return false;
    } else {
      if (await partsRepository.addPart(part: part)) {
        // parts.add(part);
        getAllParts();
        // debugPrint("Part added success cubit message");
        emit(PartAddeddSuccessfullyState(partName: part.name));

        return true;
      } else {
        emit(PartAddeddFailureState(error: "Error while adding the part"));

        debugPrint("Part added failure cubit message");
        return false;
      }
    }
    // await getAllParts();
    // emit(PartAddeddSuccessfullyState());
  }

  Future<bool> isPartExistByMaterialNumber(
      {required int materialNumber}) async {
    // emit(PartWatingState());

    return await partsRepository.isPartExistByMaterialNumber(
        materialNumber: materialNumber);
    // await getAllParts();
    // emit(PartAddeddSuccessfullyState());
  }

  Future<void> updatePart(
      {required PartsWithMaterialNumberModel part, required String id}) async {
    if (isClosed) return;
    emit(PartWatingState());
    partsRepository.updatePart(part: part, id: id);
    await getAllParts();
    emit(PartUpdatedSuccessfullyState());
  }

  // Future updatePart(
  //     {required PartsWithMaterialNumberModel part, required String id}) async {
  //   // emit(PartWatingState());
  //   debugPrint("${part.imagePath} imageUrl in cubit");

  //   await PartsRemoteDataSource().updatePart(part: part, id: id);
  //   await getAllParts();
  //   emit(PartUpdatedSuccessfullyState());
  // }

  // Future deletePart({required String id}) async {
  //   // emit(PartWatingState());
  //   // debugPrint("${part.imagePath} imageUrl in cubit");
  //   debugPrint("${parts.length}");
  //   final p = parts.where(
  //     (element) => element.id != id,
  //   );

  //   // debugPrint("$p ");
  //   // debugPrint("${p!.id}");
  //   debugPrint("$id");

  //   // await PartsRemoteDataSource().deletePart(id: id);
  //   // await PartsRemoteDataSource().updatePart(part: part, id: id);
  //   // getAllParts();
  //   emit(PartDeletedSuccessfullyState());
  //   emit(PartsLoadedSuccessfullyState(parts: p.toList()));
  // }
}
