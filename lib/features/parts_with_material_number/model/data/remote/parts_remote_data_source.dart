import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:rollshop/core/helpers/collections_paths.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';

class PartsRemoteDataSource {
  final db = FirebaseFirestore.instance;

  Future<List<PartsWithMaterialNumberModel>> getAllParts() async {
    List<PartsWithMaterialNumberModel> parts = [];
    try {
      final remoteParts =
          await db.collection(CollectionsPaths.partsWithMaterialNumber).get();
      if (remoteParts.docs.isNotEmpty) {
        for (var p in remoteParts.docs) {
          parts.add(PartsWithMaterialNumberModel.fromJson(
            json: p.data(),
            idFromFirebase: p.id,
          ));
        }
      }
      return parts;
    } catch (e) {
      return parts;
    }
  }

  Future<Unit> updatePart(
      {required PartsWithMaterialNumberModel part, required String id}) async {
    // try {
    final p = part.toJson();

    // final steps = c
    // debugPrint("${c['assemblySteps'][0]['description']}");
    await db
        .collection(CollectionsPaths.partsWithMaterialNumber)
        .doc(id)
        .set(p);
    debugPrint("$unit");
    debugPrint("Part Updated successfully");
    return Future.value(unit);
    // } catch (e) {
    //   debugPrint(e.toString());
    // }
  }

  Future<Unit> addPart({required PartsWithMaterialNumberModel part}) async {
    // try {
    final p = part.toJson();

    // final steps = c
    // debugPrint("${c['assemblySteps'][0]['description']}");
    await db.collection(CollectionsPaths.partsWithMaterialNumber).add(p);
    debugPrint("$unit");
    debugPrint("Part Added successfully");
    return Future.value(unit);
    // } catch (e) {
    //   debugPrint(e.toString());
    // }
  }

  Future<bool> deletePart({required String id}) async {
    try {
      await db
          .collection(CollectionsPaths.partsWithMaterialNumber)
          .doc(id)
          .delete()
          .then((onValue) {
        debugPrint("Part with id: $id deleted successfully!");
        return true;
      });
      return true;
    } catch (error) {
      debugPrint("Error: $error");
      return false;
    }

    // try {
    // final p = part.toJson();

    // final steps = c
    // debugPrint("${c['assemblySteps'][0]['description']}");
    // debugPrint("$unit");
    // return Future.value(unit);
    // } catch (e) {
    //   debugPrint(e.toString());
    // }
  }

  Future<bool> isPartExistByMaterialNumber(
      {required String materialNumber}) async {
    try {
      final founded = await db
          .collection(CollectionsPaths.partsWithMaterialNumber)
          .where("materialNumber", isEqualTo: materialNumber.trim())
          .get();

      // debugPrint("${founded.docs.isNotEmpty}");
      // debugPrint("${founded.docs}");
      return founded.docs.isNotEmpty;
    } catch (error) {
      debugPrint(error.toString());
      return false;
    }
  }

  Future<bool> isPartExistById({required String id}) async {
    // try {
    // final p = part.toJson();

    // final steps = c
    // debugPrint("${c['assemblySteps'][0]['description']}");
    final founded = await db
        .collection(CollectionsPaths.partsWithMaterialNumber)
        .doc(id)
        .get();
    debugPrint("${founded.exists}");
    return true;
    // if (founded.count()) {}
    // debugPrint("$unit");
  }
}
