import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rollshop/core/errors/failure.dart';
import 'package:rollshop/features/auth/model/data/remote/user_remote.dart';
import 'package:rollshop/features/auth/model/repository/user_repository.dart';
import 'package:rollshop/features/auth/model/user_model.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource userRemote;
  UserRepositoryImpl({
    required this.userRemote,
  });

  // @override
  // Future<UserModel> getUser() async {
  //   return Future.value(unit);
  // }

  @override
  Future<Either<Failure, void>> setUser({required UserModel user}) async {
    return userRemote.setUser(user: user);
  }

  @override
  Future<Either<Failure, UserCredential>>
      registerUserByEmailAndPasswordInFirebaseAuth(
          {required String email,
          required String password,
          required String phoneNumber}) async {
    return await userRemote.registerUserByEmailAndPasswordInFirebaseAuth(
        email: email, password: password, phoneNumber: phoneNumber);
  }

  @override
  Future<Either<Failure, UserCredential>> signInByEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await userRemote.signInByEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<Either<Failure, UserModel>> currentUser(
      {required String userId}) async {
    return await userRemote.getCurrentUser(userId: userId);
  }
}
