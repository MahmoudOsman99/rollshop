import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:rollshop/core/errors/failure.dart';
import 'package:rollshop/core/helpers/collections_paths.dart';
import 'package:rollshop/features/auth/model/user_model.dart';

class UserRemoteDataSource {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

//   Future<UserModel> getUser()async{
// await
//   }

  Future<Either<Failure, UserModel>> getCurrentUser(
      {required String userId}) async {
    final user =
        await db.collection(CollectionsPaths.usersPath).doc(userId).get();
    if (user.data() != null) {
      final currentUser =
          UserModel.fromJson(user.data()!, idFromFirebase: userId);
      return Right(currentUser);
    } else {
      return Left(UserSignInFailure(message: ""));
    }
  }

  Future<Either<Failure, void>> setUser({required UserModel user}) async {
    try {
      final savedUser = await db
          .collection(CollectionsPaths.usersPath)
          .doc(user.id)
          .set(user.toJson());
      return Right(savedUser);
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return Left(
          UserRegisterFailure(message: e.message ?? "Error while saving user"));
    }
  }

  Future<Either<Failure, UserCredential>> signInByEmailAndPassword({
    required String email,
    required String password,
  }) async {
    debugPrint(email);
    try {
      final user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      debugPrint(user.user?.uid);
      return Right(user);
    } on FirebaseException catch (e) {
      debugPrint("code is: ${e.code}");
      debugPrint(e.message);
      if (e.code == "invalid-credential") {
        return Left(
            UserNotFoundFailure(message: e.message ?? "User not found"));
      }
      return Left(
          UserSignInFailure(message: e.message ?? "Error while sign in"));
    }
  }

  // Future<Either<Failure, UserCredential>>
  //     registerUserByEmailAndPasswordInFirebaseAuth({
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  // final user = await auth.createUserWithEmailAndPassword(
  //     email: email, password: password);
  // return Right(user);
  //   } on FirebaseException catch (e) {
  //     return Left(UserRegisterFailure(message: e.message ?? "Error occured"));
  //   }
  // }

  Future<Either<Failure, UserCredential>>
      registerUserByEmailAndPasswordInFirebaseAuth({
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final isEmailExists = await ifUserExistByEmail(email: email);
      final isPhoneExists =
          await ifUserExistPhoneNumber(phoneNumber: phoneNumber);
      if (isEmailExists) {
        debugPrint("User founded for this email");
        return Left(EmailAlreadyExistsFailure());
      }
      if (isPhoneExists) {
        debugPrint("Phone number is already exists");
        return Left(PhoneNumberExistsFailure());
      }
      // if(ifUserExistByEmail(email: user.email))
      // final u = user.toJson();
      // await db.collection(CollectionsPaths.usersPath).add(u);
      // debugPrint("User Inserted");
      final user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Right(user);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      return Left(UnexpectedError(e.toString()));
    }
  }

  Future<bool> ifUserExistByEmail({required String email}) async {
    final result = await db
        .collection(CollectionsPaths.usersPath)
        .where("email", isEqualTo: email.toLowerCase())
        .get();
    debugPrint("Result is ${result.size}");
    return result.size > 0;
  }

  Future<bool> ifUserExistPhoneNumber({required String phoneNumber}) async {
    final result = await db
        .collection(CollectionsPaths.usersPath)
        .where("phoneNumber", isEqualTo: phoneNumber)
        .get();
    debugPrint("Result is ${result.size}");
    return result.size > 0;
  }
}
