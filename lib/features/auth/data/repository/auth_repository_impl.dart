import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rollshop/core/errors/failure.dart';
import 'package:rollshop/features/auth/data/data_source/remote/auth_remote.dart';
import 'package:rollshop/features/auth/data/repository/auth_repository.dart';
import 'package:rollshop/features/users/data/models/user_model.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemote;
  AuthRepositoryImpl({
    required this.authRemote,
  });

  // @override
  // Future<UserModel> getUser() async {
  //   return Future.value(unit);
  // }

  @override
  Future<Either<Failure, void>> setUser({required UserModel user}) async {
    return authRemote.setUser(user: user);
  }

  // @override
  // Future<Either<Failure, UserCredential>>
  //     registerUserByEmailAndPasswordInFirebaseAuth(
  //         {required String email,
  //         required String password,
  //         required String phoneNumber}) async {
  //   return await authRemote.registerUserByEmailAndPasswordInFirebaseAuth(
  //       email: email, password: password, phoneNumber: phoneNumber);
  // }

  @override
  Future<Either<Failure, UserCredential>> signInByEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await authRemote.signInByEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<Either<Failure, UserModel>> currentUser(
      {required String userId}) async {
    return await authRemote.getCurrentUser(userId: userId);
  }

  @override
  Future<Either<Failure, bool>> isUserApproved({required String email}) async {
    return await authRemote.isUserApprovedToSignin(email: email);
  }

  @override
  Future<Either<Failure, UserCredential>> registerUserByEmailAndSetUser(
      {required String password, required UserModel user}) async {
    return await authRemote.registerUserByEmailAndSetUser(
        user: user, password: password);
  }

  // @override
  // Future<UserModel> refreshUser({required String userId}) {
  //   // TODO: implement refreshUser
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<Failure, bool>> isUserExistsInWaitingUserToApproved(
  //     {required String email}) async {
  //   return await authRemote.isUserExistsInWaitingUserToApproved(email: email);
  // }

  // @override
  // Future<Either<Failure, Unit>> addWaitingUserToApprove(
  //     {required WaitingUsersToApproveModel user}) async {
  //   return await authRemote.setUser(user: user);
  // }

  // @override
  // Future<Either<Failure, List<WaitingUsersToApprove>>>
  //     getWaitingUsersToApprove() async {
  //   return await userRemote.getWaitingUsersToApprove();
  // }
}
