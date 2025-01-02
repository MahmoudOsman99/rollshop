import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:rollshop/core/helpers/collections_paths.dart';
import 'package:rollshop/features/assembly_steps_feature/models/chock_type_model.dart';

class ChockRemoteDataSource {
  final db = FirebaseFirestore.instance;

  // Future<List<ChockTypesModel>> getAllChocks() async {
  //   try {
  //     await chocks.add({});
  //   } catch (e) {}
  // }

  Future<Unit> addChock(ChockTypesModel chock) async {
    // try {
    final c = chock.toJson();
    await db.collection(CollectionsPaths.chockPath).add(c);
    debugPrint("$unit");
    return Future.value(unit);

    // } catch (e) {
    //   debugPrint(e.toString());
    // }
  }
}
