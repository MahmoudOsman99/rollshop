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

  // void isSavingProccess(bool value) {
  //   isSaving = value;
  //   debugPrint(isSaving.toString());
  //   emit(AuthIsSavingState(isSaving: isSaving));
  // }

  // Future<void> addWaitingUserToApprove(
  //     {required WaitingUsersToApproveModel user}) async {
  //   final addedUser = await repo.addWaitingUser(user: user);

  //   addedUser.fold((failure) {
  //     emit(AddWaitingUserToApproveFailedState(error: failure.message));
  //   }, (unit) {
  //     emit(AddWaitingUserToApproveSuccessState());
  //   });
  // }

  // Future<void> signIn({
  //   required String email,
  //   required String password,
  // }) async {
  //   emit(AuthLoginLoadingState());
  //   try {
  //     final UserCredential user = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);

  //     debugPrint(user.user.toString());
  //     // if (!isApprovedToSignin) {
  //     //   emit(UserNotApprovedToSigninState());
  //     //   return;
  //     // }
  //     // final userCredential = await authRepo.signInByEmailAndPassword(
  //     //   email: email,
  //     //   password: password,
  //     // );
  //     // userCredential.fold((failure) {
  //     //   emit(AuthLoginFailureState(failure: failure));
  //     // }, (user) async {
  //     //   final getCurrentUser =
  //     //       await authRepo.currentUser(userId: user.user!.uid);
  //     //   getCurrentUser.fold((failure) {
  //     //     emit(AuthLoginFailureState(failure: failure));
  //     //   }, (cUser) {
  //     //     currentUser = cUser;
  //     //   });
  //     //   emit(AuthLoginSuccessState(user: user));
  //     // });
  //     // User is now signed in.
  //     // print('Signed in with email: ${userCredential.user!.email}');
  //   } on FirebaseAuthException catch (e) {
  //     debugPrint(e.code);
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     }
  //   }
  // }

  // Future<void> signUp({required String email, required String password}) async {
  //   try {
  //     // final registeredUser = await FirebaseAuth.instance
  //     //     .createUserWithEmailAndPassword(email: email, password: password);
  //     // debugPrint(registeredUser.user!.email);
  //     // await  FirebaseAuth.instance.fetchSignInMethodsForEmail(email)
  //   } on FirebaseException catch (e) {
  //     debugPrint(e.code); // email-already-in-use
  //   }
  // }

  // Future<bool> ifExists(String email) async {
  //   try {
  //     // Fetch sign-in methods for the email address
  //     final list =
  //         await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

  //     // If the list is not empty, the email exists
  //     return list.isNotEmpty;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'invalid-email') {
  //       print('Invalid email address format.');
  //     } else {
  //       print('Error checking email: ${e.message}');
  //     }
  //     return false;
  //   }
  // }

  Future<void> registerByEmailAndPassword({
    required String email,
    required String password,
    required String phoneNumber,
    required String name,
    required String userType,
  }) async {
    emit(UserRegisteringState());
    try {
      // final isExists =
      //     await authRepo.isUserExistsInWaitingUserToApproved(email: email);
      // isExists.fold((failure) {
      //   emit(WaitingUserErrorState(error: failure.message));
      //   return;
      // }, (value) {
      //   if (value) {
      //     emit(WaitingUserFoundedState());
      //     return;
      //   }
      // });
      final createUserWithEmailInFirebaseAuthResult =
          await authRepo.registerUserByEmailAndPasswordInFirebaseAuth(
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
            isApproved: false,
          );
          final createUser = await authRepo.setUser(user: user);
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
      debugPrint(e.code);
      emit(UserRegisterFailedState(failure: UnexpectedError(e.toString())));
    }
  }

  Future<void> isUserApprovedToSignin(
      {required String email, required String password}) async {
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
    // return await authRepo.isUserApproved(email: email);
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(AuthLoginLoadingState());
    try {
      // if (!isApprovedToSignin) {
      //   emit(UserNotApprovedToSigninState());
      //   return;
      // }
      final userCredential = await authRepo.signInByEmailAndPassword(
        email: email,
        password: password,
      );
      userCredential.fold((failure) {
        emit(AuthLoginFailureState(failure: failure));
      }, (user) async {
        final getCurrentUser =
            await authRepo.currentUser(userId: user.user!.uid);
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
