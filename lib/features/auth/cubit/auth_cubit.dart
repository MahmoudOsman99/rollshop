import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollshop/core/errors/failure.dart';
import 'package:rollshop/features/auth/cubit/auth_state.dart';
import 'package:rollshop/features/auth/model/repository/user_repository.dart';
import 'package:rollshop/features/auth/model/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.userRepo}) : super(LoginInitialState());
  final UserRepository userRepo;
  UserModel? currentUser;

  bool showPassword = false;

  void changeShowPassword() {
    showPassword = !showPassword;
    emit(LoginShowPasswordState(showPassword: showPassword));
  }

  Future<void> registerByEmailAndPassword({
    required String email,
    required String password,
    required String phoneNumber,
    required String name,
    required String userType,
  }) async {
    emit(UserRegisteringState());
    try {
      final createUserWithEmailInFirebaseAuthResult =
          await userRepo.registerUserByEmailAndPasswordInFirebaseAuth(
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );

      createUserWithEmailInFirebaseAuthResult.fold(
        (failure) {
          emit(UserRegisterFailedState(failure: failure));
        },
        (userCredential) async {
          final user = UserModel(
            id: userCredential.user?.uid,
            name: name,
            email: email,
            userType: userType,
            phoneNumber: phoneNumber,
          );
          final createUser = await userRepo.setUser(user: user);
          createUser.fold((failure) {
            emit(UserRegisterFailedState(failure: failure));
          }, (_) async {
            emit(UserRegisterSuccessState());
          });
          // final createUserResult = await userRepo.createUser(
          //   user: UserModel(
          //     id: userCredential.user!.uid,
          //     name: name,
          //     email: email,
          //     password: password,
          //     userType: userType,
          //     phoneNumber: phoneNumber,
          //   ),
          // );

          // createUserResult.fold(
          //   (failure) {
          //     emit(UserRegisterFailedState(failure: failure));
          //   },
          //   (_) {
          //     emit(UserRegisterSuccessState());
          //   },
          // );
        },
      );
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      emit(UserRegisterFailedState(failure: UnexpectedError(e.toString())));
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(AuthLoginLoadingState());
    try {
      final userCredential = await userRepo.signInByEmailAndPassword(
        email: email,
        password: password,
      );
      userCredential.fold((failure) {
        emit(AuthLoginFailureState(failure: failure));
      }, (user) async {
        final getCurrentUser =
            await userRepo.currentUser(userId: user.user!.uid);
        getCurrentUser.fold((failure) {
          emit(AuthLoginFailureState(failure: failure));
        }, (cUser) {
          currentUser = cUser;
        });
        emit(AuthLoginSuccessState(user: user));
      });
      // User is now signed in.
      // print('Signed in with email: ${userCredential.user!.email}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
    }
  }

  // void loginWithEmailAndPassword() {}
  // void loginByGoogleWithFirebase() {}

  // Future<void> registerWithEmailAndPassword(
  //     {required String email, required String password}) async {
  //   emit(UserRegistering());
  //   try {
  //     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     // Create a User document in Firestore
  //     await _firestore
  //         .collection('users')
  //         .doc(userCredential.user!.uid)
  //         .set(
  //           {
  //             'email': email,
  //             'displayName': '', // You can set a default display name here
  //           },
  //         );

  //     // Get the user data from Firestore
  //     DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore
  //         .collection('users')
  //         .doc(userCredential.user!.uid)
  //         .get();
  //     UserModel user = UserModel.fromFirestore(userDoc);

  //     emit(UserRegisteredSuccessfully(user: user));
  //   } on FirebaseAuthException catch (e) {
  //     emit(UserRegisterFailed(errorMessage: e.message ?? 'Registration failed'));
  //   }
}
