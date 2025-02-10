import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:rollshop/core/errors/failure.dart';
import 'package:rollshop/core/helpers/collections_paths.dart';
import 'package:rollshop/features/users/data/models/user_model.dart';

class AuthRemoteDataSource {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  // final userRemote = sl<UserRemoteDataSource>();

//   Future<UserModel> getUser()async{
// await
//   }

  // Future<Either<Failure, List<WaitingUsersToApprove>>>
  //     getWaitingUsersToApprove() async {
  //   try {
  //     final List<WaitingUsersToApprove> watingUsersList = [];
  //     final wUsers =
  //         await db.collection(CollectionsPaths.watingUsersToApprovePath).get();
  //     if (wUsers.docs.isNotEmpty) {
  //       wUsers.docs.map((u) {
  //         watingUsersList.add(WaitingUsersToApprove.fromJson(u.data()));
  //       });
  //     }
  //     return Right(watingUsersList);
  //   } on FirebaseException catch (e) {
  //     debugPrint(e.message);
  //     return Left(NoWaitingUsersFailure(e.message ?? "No waiting users found"));
  //   }
  // }

  Future<Either<Failure, UserModel>> getCurrentUser(
      {required String userId}) async {
    final user =
        await db.collection(CollectionsPaths.usersPath).doc(userId).get();
    if (user.data() != null) {
      final currentUser =
          UserModel.fromJson(user.data()!, idFromFirebase: userId);
      return Right(currentUser);
    } else {
      return Left(UserEmailOrPasswordFailure(message: ""));
    }
  }

  Future<Either<Failure, Unit>> setUser({required UserModel user}) async {
    try {
      // final savedUser =
      await db
          .collection(CollectionsPaths.usersPath)
          .doc(user.id)
          .set(user.toJson());
      // await db
      //     .collection(CollectionsPaths.waitingUsersToApprovePath)
      //     .add(user.toJson());
      return Right(unit);
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
    // debugPrint(email);
    // final isUserApprovedToSignin =
    //     await userRemote.isUserApprovedToSignin(email: email).then((isApproved){
    //       if(isApproved.isRight()){

    //       }
    //     });
    try {
      final user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      debugPrint(user.user?.uid);
      return Right(user);
    } on FirebaseException catch (e) {
      // debugPrint("code is: ${e.code}");
      // debugPrint(e.message);
      if (e.code == "invalid-credential") {
        return Left(
          UserEmailOrPasswordFailure(
            message: e.message ?? "Email or password incorrect",
          ),
        );
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
      final isEmailExists = await ifUserExistByEmailInUsers(email: email);
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
      final user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Right(user);
    } on FirebaseException catch (e) {
      // debugPrint(e.toString());
      if (e.code == "email-already-in-use") {
        debugPrint("email-already-in-use try to sign in");
        return Left(EmailAlreadyExistsFailure());
      }
      // debugPrint("${e.message} ${e.code}");
      // debugPrint("${e.message} in exception");

      return Left(UnexpectedError(e.toString()));
    }
  }

  Future<bool> ifUserExistByEmailInUsers({required String email}) async {
    final result = await db
        .collection(CollectionsPaths.usersPath)
        .where("email", isEqualTo: email.toLowerCase())
        .get();
    debugPrint("Result is ${result.size}");

    // final resultInWaitingUsersToApproved = await db
    //     .collection(CollectionsPaths.waitingUsersToApprovePath)
    //     .where("email", isEqualTo: email.toLowerCase())
    //     .get();
    // debugPrint("Result is ${resultInWaitingUsersToApproved.size}");
    if (result.size > 0) {
      return true;
    }
    return false;
  }

  Future<bool> ifUserExistPhoneNumber({required String phoneNumber}) async {
    final result = await db
        .collection(CollectionsPaths.usersPath)
        .where("phoneNumber", isEqualTo: phoneNumber)
        .get();
    debugPrint("Result is ${result.size}");
    return result.size > 0;
  }

  Future<Either<Failure, bool>> isUserApprovedToSignin(
      {required String email}) async {
    try {
      final isUserApprovedToSigninCheck = await db
          .collection(CollectionsPaths.usersPath)
          .where("email", isEqualTo: email.toLowerCase())
          .get();
      if (isUserApprovedToSigninCheck.docs.isEmpty) {
        debugPrint("No user founded for this email");
        return Left(UserNotFoundFailure(message: "User not founded"));
      } else {
        if (isUserApprovedToSigninCheck.docs.first.data()["isApproved"] ==
            null) {
          return Right(false);
        } else {
          debugPrint(isUserApprovedToSigninCheck.docs.first
              .data()["isApproved"]
              .toString());
          return Right(isUserApprovedToSigninCheck.docs.first
              .data()["isApproved"] as bool);
        }
      }
      // return Right(_r);
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return Left(UnexpectedError(e.message ?? ""));
    }
  }

  // Future<Either<Failure, bool>> isUserExistsInWaitingUserToApproved(
  //     {required String email}) async {
  //   try {
  //     final isExistByEmail = await db
  //         .collection(CollectionsPaths.waitingUsersToApprovePath)
  //         .where("email", isEqualTo: email)
  //         .get();

  //     if (isExistByEmail.size > 0) {
  //       return Right(true);
  //     } else {
  //       return Right(false);
  //     }
  //   } on FirebaseException catch (e) {
  //     debugPrint("${e.message} in exception");
  //     return Left(NoWaitingUserFoundedFailure(e.message ?? "Error in server"));
  //   }
  // }
}
