import 'package:dartz/dartz.dart';
import 'package:rollshop/features/chock_feature/models/chock_type_model.dart';

abstract class ChockRepository {
  Future<List<ChockTypesModel>> getAllChocks();
  Future<Unit> addChock();
  Future<Unit> updateChock();
  // Future<bool> deletePart({required String id});
  // Future<Unit> addPart({required ChockTypesModel part});
  // Future<Unit> updatePart(
  //     {required ChockTypesModel part, required String id});
  // Future<bool> isPartExistByMaterialNumber({required String materialNumber});
}
