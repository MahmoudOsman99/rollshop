import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UserModel extends Equatable {
  final String? id;
  final String name;
  final String email;
  final String phoneNumber;
  final bool isApproved;
  final bool? isEmailVerified;
  final bool? isPhoneVerified;
  final bool? isBanned;
  final Timestamp? createdAt;
  final String userType; // Example: "admin", "user", "guest"
  final String? imagePath; // Optional: Image path
  // final String? rulesId;
  // final RulesModel? rulesModel;

  const UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.userType,
    required this.phoneNumber,
    required this.isApproved,
    this.isEmailVerified,
    this.createdAt,
    this.isPhoneVerified,
    this.isBanned,
    this.imagePath,
    // this.rulesModel,
  });

  @override
  List<Object?> get props =>
      [id, name, email, userType, phoneNumber, imagePath];

  factory UserModel.fromJson(Map<String, dynamic> json,
      {String? idFromFirebase}) {
    // final Timestamp timestamp = json["createdAt"];
    debugPrint(json["createdAt"].toString());
    return UserModel(
      id: idFromFirebase ?? json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      userType: json["userType"],
      isEmailVerified: json["isEmailVerified"] ?? false,
      isPhoneVerified: json["isPhoneVerified"] ?? false,
      isBanned: json["isBanned"] ?? false,
      isApproved: json["isApproved"] ?? false,
      createdAt: json["createdAt"] ?? "",
      phoneNumber: json['phoneNumber'] ?? '',
      imagePath: json['imagePath'], // Handle potential null value
      // userType: json["userType"] != null
      //     ? UserType.values.firstWhere(json['userType'])
      //     : UserType.technician,
      // json['userType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email.toLowerCase(),
      'phoneNumber': phoneNumber,
      'userType': userType,
      'imagePath': imagePath,
      "createdAt": createdAt,
      "isPhoneVerified": isPhoneVerified ?? false,
      "isEmailVerified": isEmailVerified ?? false,
      "isBanned": isBanned ?? false,
      "isApproved": isApproved,
    };
  }
}

enum UserType {
  admin,
  engineer,
  foreman,
  technician,
  user,
}
