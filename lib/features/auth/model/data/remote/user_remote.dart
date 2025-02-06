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
  Future<Either<Failure, UserCredential>> signInByEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return Right(user);
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return Left(
          UserSignInFailure(message: e.message ?? "Error while sign in"));
    }
  }

  Future<Either<Failure, UserCredential>>
      registerUserByEmailAndPasswordInFirebaseAuth({
    required String email,
    required String password,
  }) async {
    try {
      final user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Right(user);
    } on FirebaseException catch (e) {
      return Left(UserRegisterError(message: e.message ?? "Error occured"));
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

  Future<Either<Failure, Unit>> registerUser({
    required UserModel user,
  }) async {
    try {
      final isEmailExists = await ifUserExistByEmail(email: user.email);
      final isPhoneExists =
          await ifUserExistPhoneNumber(phoneNumber: user.phoneNumber);
      if (isEmailExists) {
        debugPrint("User founded for this email");
        return Left(EmailAlreadyExistsFailure());
      }
      if (isPhoneExists) {
        debugPrint("Phone number is already exists");
        return Left(PhoneNumberExistsFailure());
      }
      // if(ifUserExistByEmail(email: user.email))
      final u = user.toJson();
      await db.collection(CollectionsPaths.usersPath).add(u);
      debugPrint("User Inserted");
      return Right(unit);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      return Left(UnexpectedError(e.toString()));
    }
  }
}
