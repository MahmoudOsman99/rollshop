import 'package:dartz/dartz.dart';
import 'package:rollshop/features/auth/signin/model/user_model.dart';

abstract class UserRepository {
  Future<UserModel> getUser();
  Future<Unit> registerUser();
}
