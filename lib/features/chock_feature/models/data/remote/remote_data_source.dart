import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter/material.dart';
import 'package:rollshop/core/helpers/collections_paths.dart';
import 'package:rollshop/features/chock_feature/models/bearing_types_model.dart';

import 'package:rollshop/features/chock_feature/models/chock_type_model.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';

class ChockRemoteDataSource {
  final db = FirebaseFirestore.instance;

  Future<List<ChockTypesModel>> getAllChocks() async {
    final chocksFromDB =
        await db.collection(CollectionsPaths.chockPath).orderBy("name").get();
    final List<ChockTypesModel> chocks = [];
    // return [];
    if (chocksFromDB.docs.isNotEmpty) {
      // debugPrint("not empty");
      // debugPrint("${chocksFromDB.docs.first}");
      for (var c in chocksFromDB.docs) {
        // debugPrint("${c.data()}");
        chocks.add(
            ChockTypesModel.fromJson(json: c.data(), idFromFirebase: c.id));
      }
      return chocks;
      // debugPrint(chocks.first.assemblySteps.first.id);
      // debugPrint("get all chocks");
    } else {
      return [];
    }
  }

  Future<List<BearingTypesModel>> getBearingTypes() async {
    final List<BearingTypesModel> bearingTypes = [];
    try {
      final types =
          await db.collection(CollectionsPaths.bearingTypesPath).get();
      if (types.docs.isNotEmpty) {
        // if (types.docs.first.data()["types"] == List) {
        //   debugPrint("Ok");
        // }
        for (var type in types.docs.first.data()["types"]) {
          bearingTypes.add(BearingTypesModel(name: type ?? ""));
        }
      }
      return Future.value(bearingTypes);
    } catch (e) {
      return Future.value(bearingTypes);
    }
  }

  Future<List<PartsWithMaterialNumberModel>> getAllParts() async {
    final partsFromDB =
        await db.collection(CollectionsPaths.partsWithMaterialNumber).get();
    final List<PartsWithMaterialNumberModel> parts = [];
    if (partsFromDB.docs.isNotEmpty) {
      // debugPrint("not empty");
      // debugPrint("${chocksFromDB.docs.first}");
      for (var c in partsFromDB.docs) {
        // debugPrint("${c.data()['name']}");
        parts.add(PartsWithMaterialNumberModel.fromJson(
            json: c.data(), idFromFirebase: c.id));
      }
      return parts;
      // debugPrint(chocks.first.assemblySteps.first.id);
      // debugPrint("get all chocks");
    } else {
      return [];
    }
  }

  // Future<List<ChockTypesModel>> getAllChocks() async {
  //   try {
  //     final chocksFromDB =
  //         await db.collection(CollectionsPaths.chockPath).get();

  //     return [ChockTypesModel()]
  //   } catch (e) {}
  // }

  Future<Unit> addChock({required ChockTypesModel chock}) async {
    try {
      final c = chock.toJson();

      // final steps = c
      // debugPrint("${c['assemblySteps'][0]['description']}");
      await db.collection(CollectionsPaths.chockPath).add(c);
      debugPrint("$unit");
      debugPrint("added successfully");
      return Future.value(unit);
    } catch (e) {
      debugPrint(e.toString());
      return Future.value(unit);
    }
  }
}
