import 'package:dartz/dartz.dart';
import 'package:rollshop/core/helpers/internet_connection_checker.dart';
import 'package:rollshop/features/parts_with_material_number/model/data/remote/parts_remote_data_source.dart';
import 'package:rollshop/features/parts_with_material_number/model/data/repository/parts_repository.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';

class PartsRepoImplment extends PartsRepository {
  final PartsRemoteDataSource partsRemoteDataSource;

  PartsRepoImplment({required this.partsRemoteDataSource});
  @override
  Future<List<PartsWithMaterialNumberModel>> getParts() async {
    // if (await checkInternetConnection()) {
    return await partsRemoteDataSource.getAllPartsFromFirebase();
    // } else {
    //   return [];
    // }
  }

  @override
  Future<bool> deletePart({required String id}) async {
    return await partsRemoteDataSource.deletePart(id: id);
  }

  @override
  Future<Unit> addPart({required PartsWithMaterialNumberModel part}) async {
    return await partsRemoteDataSource.addPart(part: part);
  }

  @override
  Future<bool> isPartExistByMaterialNumber(
      {required String materialNumber}) async {
    return await partsRemoteDataSource.isPartExistByMaterialNumber(
        materialNumber: materialNumber);
  }

  @override
  Future<Unit> updatePart(
      {required PartsWithMaterialNumberModel part, required String id}) async {
    await partsRemoteDataSource.updatePart(part: part, id: id);
    return Future.value(unit);
  }
}
