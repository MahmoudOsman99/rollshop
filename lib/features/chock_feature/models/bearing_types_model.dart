import 'package:flutter/material.dart';

class BearingTypesModel {
  String? id;
  String name;
  BearingTypesModel({
    this.id,
    required this.name,
  });

  factory BearingTypesModel.fromJson(
      {required Map<String, dynamic> json, String? idFromFireStore}) {
    debugPrint(json.toString());
    // final List<dynamic> types;
    debugPrint(json.length.toString());
    return BearingTypesModel(
      id: idFromFireStore ?? json["id"],
      name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toJson(BearingTypesModel bearingType) {
    return {
      "name": bearingType.name,
    };
  }
}
