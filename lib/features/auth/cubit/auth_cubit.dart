import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollshop/core/errors/failure.dart';
import 'package:rollshop/features/auth/cubit/auth_state.dart';
import 'package:rollshop/features/auth/data/repository/auth_repository.dart';
import 'package:rollshop/features/users/data/models/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepo}) : super(LoginInitialState());
  final AuthRepository authRepo;
  UserModel? currentUser;

  bool showPassword = false;
  // bool isSaving = false;

  void changeShowPassword() {
    showPassword = !showPassword;
    emit(LoginShowPasswordState(showPassword: showPassword));
  }

  Future<void> refreshUser() async {
    final user = await authRepo.currentUser(userId: currentUser!.id!);
    user.fold((failure) {}, (user) {
      currentUser = user;
      emit(UserRefreshSuccessState());
    });
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
      final UserModel userModel = UserModel(
        name: name,
        email: email,
        userType: userType,
        phoneNumber: phoneNumber,
        isApproved: false,
      );
      final createUserWithEmailInFirebaseAuthResult =
          await authRepo.registerUserByEmailAndSetUser(
        user: userModel,
        password: password,
      );

      createUserWithEmailInFirebaseAuthResult.fold(
        (failure) {
          emit(UserRegisterFailedState(failure: failure));
        },
        (UserCredential userCredencial) async {
          final user = UserModel(
            id: userCredencial.user!.uid,
            name: name,
            email: email,
            userType: userType,
            phoneNumber: phoneNumber,
            isApproved: false,
            isBanned: false,
            isEmailVerified: false,
            isPhoneVerified: false,
            createdAt: Timestamp.fromDate(DateTime.now()),
          );
          final createdUser = await authRepo.setUser(user: user);
          createdUser.fold((failure) {
            emit(UserRegisterFailedState(failure: failure));
          }, (_) {
            emit(UserRegisterSuccessState());
          });
        },
      );
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      debugPrint(e.code);
      emit(UserRegisterFailedState(failure: UnexpectedError(e.toString())));
    }
  }

  Future<void> isUserApprovedToSignin(
      {required String email, required String password}) async {
    emit(AuthLoginLoadingState());
    final isApprovedToSignin = await authRepo.isUserApproved(email: email);
    isApprovedToSignin.fold((failure) {
      emit(AuthLoginFailureState(failure: failure));
    }, (result) {
      if (result) {
        signInWithEmailAndPassword(email: email, password: password);
      } else {
        emit(UserNotApprovedToSigninState());
      }
    });
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(AuthLoginLoadingState());
    // try {
    final userCredential = await authRepo.signInByEmailAndPassword(
      email: email,
      password: password,
    );
    userCredential.fold((failure) {
      emit(AuthLoginFailureState(failure: failure));
    }, (user) async {
      final getCurrentUser = await authRepo.currentUser(userId: user.user!.uid);
      getCurrentUser.fold((failure) {
        emit(AuthLoginFailureState(failure: failure));
      }, (cUser) async {
        currentUser = cUser;
      });
      emit(AuthLoginSuccessState(user: user));
    });
    // User is now signed in.
    // print('Signed in with email: ${userCredential.user!.email}');
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'user-not-found') {
    //     print('No user found for that email.');
    //   } else if (e.code == 'wrong-password') {
    //     print('Wrong password provided for that user.');
    // }
    // }
  }

  Future<void> signoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();

      emit(AuthSignedOutState());
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
