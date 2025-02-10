import 'package:dartz/dartz.dart';
import 'package:rollshop/core/errors/failure.dart';
import 'package:rollshop/features/users/data/models/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserModel>>> getWaitingUsersToApprove();
  Future<Either<Failure, void>> setUser({required UserModel user});
  // Future<Either<Failure, Unit>> addWaitingUser(
  //     {required WaitingUsersToApproveModel user});

  // Future<bool> isUserApprovedToSignin({required String email});
  // Future<Either<Failure, UserModel>> currentUser({required String userId});
  // Future<Either<Failure, UserCredential>> signInByEmailAndPassword(
  //     {required String email, required String password});
  // Future<Either<Failure, void>> setUser({required UserModel user});
  // Future<Either<Failure, UserCredential>>
  // registerUserByEmailAndPasswordInFirebaseAuth(
  // {required String email,
  // required String password,
  // required String phoneNumber});
}
