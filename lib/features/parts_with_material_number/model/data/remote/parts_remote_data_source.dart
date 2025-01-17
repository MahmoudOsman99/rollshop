import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:rollshop/core/helpers/collections_paths.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';

class PartsRemoteDataSource {
  final db = FirebaseFirestore.instance;

  Future<List<PartsWithMaterialNumberModel>> getAllPartsFromFirebase() async {
    List<PartsWithMaterialNumberModel> parts = [];
    try {
      final remoteParts = await db
          .collection(CollectionsPaths.partsWithMaterialNumber)
          .orderBy("name")
          .get();
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
        .update(p);
    debugPrint("$unit");
    debugPrint("Part Updated successfully");
    return Future.value(unit);
    // } catch (e) {
    //   debugPrint(e.toString());
    // }
  }

  Future<bool> addPart({required PartsWithMaterialNumberModel part}) async {
    try {
      final p = part.toJson();
      // if (await isPartExistByMaterialNumber(
      //     materialNumber: part.materialNumber)) {
      //   return false;
      // } else {
      await db.collection(CollectionsPaths.partsWithMaterialNumber).add(p);
      debugPrint("Part Added successfully");
      return true;
      // }
    } catch (e) {
      debugPrint("Error while add the part in remote data");
      return false;
    }
    // try {
    // final p = part.toJson();

    // final steps = c
    // debugPrint("${c['assemblySteps'][0]['description']}");
    // await db.collection(CollectionsPaths.partsWithMaterialNumber).add(p);
    // debugPrint("$unit");
    // debugPrint("Part Added successfully");
    // return Future.value(unit);
    // } catch (e) {
    //   debugPrint(e.toString());
    // }
  }

  Future<bool> deletePart({required String id}) async {
    if (id == null || id.isEmpty) {
      debugPrint("Id is null");
      return false;
    }
    // debugPrint("Part with id: $id ");
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
      {required int materialNumber}) async {
    try {
      final founded = await db
          .collection(CollectionsPaths.partsWithMaterialNumber)
          .where("materialNumber", isEqualTo: materialNumber)
          .get();

      // debugPrint("${founded.docs.isNotEmpty}");
      debugPrint("${founded.docs.length} is found with same material number");
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
