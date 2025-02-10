import 'package:dartz/dartz.dart';
import 'package:rollshop/core/errors/failure.dart';
import 'package:rollshop/features/users/data/models/user_model.dart';
import 'package:rollshop/features/users/data/remote/user_remote_data_source.dart';
import 'package:rollshop/features/users/data/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource userRemote;
  UserRepositoryImpl({
    required this.userRemote,
  });

  // @override
  // Future<UserModel> getUser() async {
  //   return Future.value(unit);
  // }

  // @override
  // Future<Either<Failure, void>> setUser({required UserModel user}) async {
  //   return userRemote.setUser(user: user);
  // }

  // @override
  // Future<Either<Failure, UserCredential>>
  //     registerUserByEmailAndPasswordInFirebaseAuth(
  //         {required String email,
  //         required String password,
  //         required String phoneNumber}) async {
  //   return await userRemote.registerUserByEmailAndPasswordInFirebaseAuth(
  //       email: email, password: password, phoneNumber: phoneNumber);
  // }

  // @override
  // Future<Either<Failure, UserCredential>> signInByEmailAndPassword({
  //   required String email,
  //   required String password,
  // }) async {
  //   return await userRemote.signInByEmailAndPassword(
  //       email: email, password: password);
  // }

  // @override
  // Future<Either<Failure, UserModel>> currentUser(
  //     {required String userId}) async {
  //   return await userRemote.getCurrentUser(userId: userId);
  // }

  @override
  Future<Either<Failure, List<UserModel>>> getWaitingUsersToApprove() async {
    return await userRemote.getWaitingUsersToApprove();
  }

  // @override
  // Future<Either<Failure, Unit>> addWaitingUser(
  //     {required WaitingUsersToApproveModel user}) async {
  //   return await userRemote.addWaitingUser(user: user);
  // }

  // @override
  // Future<bool> isUserApprovedToSignin({required String email}) async {
  //   return await userRemote.isUserApprovedToSignin(email: email);
  // }
}
