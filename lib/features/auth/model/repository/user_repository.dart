import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rollshop/core/errors/failure.dart';
import 'package:rollshop/features/auth/model/user_model.dart';

abstract class UserRepository {
  // Future<Either<Failure, UserModel>> getUser();
  Future<Either<Failure, UserCredential>> signInByEmailAndPassword(
      {required String email, required String password});
  Future<Either<Failure, Unit>> createUser({required UserModel user});
  Future<Either<Failure, UserCredential>>
      registerUserByEmailAndPasswordInFirebaseAuth(
          {required String email, required String password});
}
