import 'package:dartz/dartz.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';

abstract class PartsRepository {
  Future<List<PartsWithMaterialNumberModel>> getParts();
  Future<bool> deletePart({required String id});
  Future<Unit> addPart({required PartsWithMaterialNumberModel part});
  Future<Unit> updatePart(
      {required PartsWithMaterialNumberModel part, required String id});
  Future<bool> isPartExistByMaterialNumber({required String materialNumber});
}
