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

  Future<Either<Failure, UserCredential>> signInByEmailAndPassword({
    required String email,
    required String password,
  }) async {
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

  //! do not remove
  // Future<Either<Failure, UserCredential>>
  //     registerUserByEmailAndPasswordInFirebaseAuth({
  //   required String email,
  //   required String phoneNumber,
  //   required String password,
  // }) async {
  //   try {
  //     final isEmailExists = await ifUserExistByEmailInUsers(email: email);
  //     final isPhoneExists =
  //         await ifUserExistPhoneNumber(phoneNumber: phoneNumber);
  //     if (isEmailExists) {
  //       debugPrint("User founded for this email");
  //       return Left(EmailAlreadyExistsFailure());
  //     }
  //     if (isPhoneExists) {
  //       debugPrint("Phone number is already exists");
  //       return Left(PhoneNumberExistsFailure());
  //     }
  //     final user = await auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     return Right(user);
  //   } on FirebaseException catch (e) {
  //     // debugPrint(e.toString());
  //     if (e.code == "email-already-in-use") {
  //       debugPrint("email-already-in-use try to sign in");
  //       return Left(EmailAlreadyExistsFailure());
  //     }
  //     // debugPrint("${e.message} ${e.code}");
  //     // debugPrint("${e.message} in exception");

  //     return Left(UnexpectedError(e.toString()));
  //   }
  // }

  Future<Either<Failure, Unit>> setUser({required UserModel user}) async {
    try {
      await db
          .collection(CollectionsPaths.usersPath)
          .doc(user.id)
          .set(user.toJson());
      return Right(unit);
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      debugPrint(e.code);
      return Left(
          UserRegisterFailure(message: e.message ?? "Error while saving user"));
    }
  }

  Future<Either<Failure, UserCredential>> registerUserByEmailAndSetUser({
    required UserModel user,
    required String password,
  }) async {
    try {
      // this is to register the user inside the firebase auth
      if (await ifUserExistByPhoneNumber(phoneNumber: user.phoneNumber)) {
        return Left(PhoneNumberExistsFailure());
      }
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
              email: user.email.toLowerCase(), password: password);
      return Right(userCredential);
    } on FirebaseException catch (e) {
      if (e.code == "email-already-in-use") {
        return Left(EmailAlreadyExistsFailure());
      }
      debugPrint(e.code);
      return Left(UnexpectedError(e.message ?? ""));
    }
    // this is for set new user inside database
    // final UserModel userModel = UserModel(
    //   id: userCredential.user!.uid,
    //   name: user.name,
    //   email: user.email,
    //   userType: user.userType,
    //   phoneNumber: user.phoneNumber,
    //   isBanned: false,
    //   isEmailVerified: false,
    //   isPhoneVerified: false,
    //   createdAt: Timestamp.fromDate(DateTime.now()),
    //   isApproved: false,
    // );
    // setUser(user: userModel);
    // return Right(true);
    // });
    // } on firebas catch (e) {
    //   debugPrint(e.toString());
    //   return Left(UserRegisterFailure(message: "Error in register"));
    // }
    // } on FirebaseAuthException catch (e) {
    //   debugPrint(e.code);
    //   debugPrint(e.message);
    //   return Left(UserRegisterFailure(
    //       message: e.message ?? "Error while register user"));
    // }
  }

  Future<bool> ifUserExistByEmailInUsers({required String email}) async {
    final result = await db
        .collection(CollectionsPaths.usersPath)
        .where("email", isEqualTo: email.toLowerCase())
        .get();
    debugPrint("User founded for email $email");

    if (result.size > 0) {
      return true;
    }
    return false;
  }

  Future<bool> ifUserExistByPhoneNumber({required String phoneNumber}) async {
    final result = await db
        .collection(CollectionsPaths.usersPath)
        .where("phoneNumber", isEqualTo: phoneNumber)
        .get();
    debugPrint("User founded for phone $phoneNumber");
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
