import 'package:dartz/dartz.dart';
import 'package:rollshop/features/chock_feature/models/bearing_types_model.dart';
import 'package:rollshop/features/chock_feature/models/chock_type_model.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';

abstract class ChockRepository {
  Future<List<ChockTypesModel>> getAllChocks();
  Future<List<BearingTypesModel>> getBearingTypes();
  Future<Unit> addChock({required ChockTypesModel chock});
  Future<Unit> updateChock();
  Future<List<PartsWithMaterialNumberModel>> getAllParts();
  // Future<bool> deletePart({required String id});
  // Future<Unit> addPart({required ChockTypesModel part});
  // Future<Unit> updatePart(
  //     {required ChockTypesModel part, required String id});
  // Future<bool> isPartExistByMaterialNumber({required String materialNumber});
}
