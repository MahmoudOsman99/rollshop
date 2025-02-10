import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:rollshop/core/errors/failure.dart';
import 'package:rollshop/core/helpers/collections_paths.dart';
import 'package:rollshop/features/users/data/models/user_model.dart';

class UserRemoteDataSource {
  final db = FirebaseFirestore.instance;

  // Future<Either<Failure, Unit>> addWaitingUser(
  //     {required WaitingUsersToApproveModel user}) async {
  //   final u = user.toJson();
  //   try {
  //     await db.collection(CollectionsPaths.waitingUsersToApprovePath).add(u);
  //     return Right(unit);
  //   } on FirebaseException catch (e) {
  //     return Left(
  //         AddWaitingUserFailure(e.message ?? "Failed to add waiting user "));
  //   }
  // }

  // Future<bool> isUserApprovedToSignin({required String email}) async {
  //   try {
  //     final user = await db
  //         .collection(CollectionsPaths.waitingUsersToApprovePath)
  //         .where("email", isEqualTo: email)
  //         .get();

  //     if (user.docs.isNotEmpty) {
  //       final isApproved = user.docs.first.data()['isApproved'] as bool;

  //       return isApproved;
  //     }
  //     // debugPrint(user.docs.first.data().toString());
  //     return false;
  //     // return Right(false);
  //   } on FirebaseException catch (e) {
  //     debugPrint(e.message);
  //     return false;
  //     // return Left(UnexpectedError(
  //     //     e.message ?? "Error while get is user approved to sign in"));
  //   }
  // }

  Future<Either<Failure, List<UserModel>>> getWaitingUsersToApprove() async {
    try {
      final List<UserModel> waitingUsersList = [];
      final wUsers = await db.collection(CollectionsPaths.usersPath).get();
      // .where("isApproved", isEqualTo: false)
      if (wUsers.docs.isNotEmpty) {
        for (var u in wUsers.docs) {
          waitingUsersList.add(UserModel.fromJson(
            u.data(),
            idFromFirebase: u.id,
          ));
        }
      }
      return Right(waitingUsersList);
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return Left(NoWaitingUsersFailure(e.message ?? "No waiting users found"));
    }
  }
}
