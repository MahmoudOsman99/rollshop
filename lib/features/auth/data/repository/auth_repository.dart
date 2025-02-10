import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rollshop/core/errors/failure.dart';
import 'package:rollshop/features/users/data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> currentUser({required String userId});
  Future<Either<Failure, UserCredential>> signInByEmailAndPassword(
      {required String email, required String password});
  Future<Either<Failure, void>> setUser({required UserModel user});
  // Future<Either<Failure, List<WaitingUsersToApprove>>>
  //     getWaitingUsersToApprove();
  Future<Either<Failure, UserCredential>>
      registerUserByEmailAndPasswordInFirebaseAuth({
    required String email,
    required String password,
    required String phoneNumber,
  });

  // Future<Either<Failure, Unit>> addWaitingUserToApprove(
  //     {required WaitingUsersToApproveModel user});

  Future<Either<Failure, bool>> isUserApproved({required String email});
  // Future<Either<Failure, bool>> isUserExistsInWaitingUserToApproved(
  //     {required String email});
}
