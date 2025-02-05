import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rollshop/features/auth/signin/model/user_model.dart';

class UserRemote {
  final db = FirebaseFirestore.instance;

//   Future<UserModel> getUser()async{
// await
//   }

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String userType,
    required String? imagePath,
  }) async {}
}
