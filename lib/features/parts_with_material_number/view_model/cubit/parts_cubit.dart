import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollshop/core/router/app_router.dart';
import 'package:rollshop/features/parts_with_material_number/model/data/remote/parts_remote_data_source.dart';
import 'package:rollshop/features/parts_with_material_number/model/data/repository/parts_repository.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';
import 'package:rollshop/features/parts_with_material_number/view_model/cubit/parts_state.dart';

class PartsCubit extends Cubit<PartsState> {
  // PartsWithMaterialNumberViewModel partViewModel;
  PartsRepository partsRepository = sl<PartsRepository>();
  PartsCubit(this.partsRepository) : super(PartsInitialState());

  static PartsCubit get(context) => BlocProvider.of(context);
  List<PartsWithMaterialNumberModel> parts = [];

  Future<void> getAllParts() async {
    if (isClosed) return;
    parts = [];
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

  Future addOnePart({required PartsWithMaterialNumberModel part}) async {
    if (isClosed) return;
    emit(PartWatingState());
    await partsRepository.addPart(part: part);
    // await getAllParts();
    parts.add(part);
    emit(PartsLoadedSuccessfullyState(parts: parts));
    // emit(PartAddeddSuccessfullyState());
  }

  Future<bool> isPartExistByMaterialNumber(
      {required String materialNumber}) async {
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
