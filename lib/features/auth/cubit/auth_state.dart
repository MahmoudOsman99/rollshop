import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rollshop/core/errors/failure.dart';

abstract class AuthState extends Equatable {}

class LoginInitialState extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserRegisteringState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoginLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoginSuccessState extends AuthState {
  final UserCredential user;
  AuthLoginSuccessState({required this.user});
  @override
  List<Object?> get props => [];
}

class UserRegisterSuccessState extends AuthState {
  @override
  List<Object?> get props => [];
}

class UserRegisterFailedState extends AuthState {
  final Failure failure;
  @override
  List<Object?> get props => [failure];
  UserRegisterFailedState({required this.failure});
}

class AuthLoginFailureState extends AuthState {
  final Failure failure;
  @override
  List<Object?> get props => [failure];
  AuthLoginFailureState({required this.failure});
}

class LoginShowPasswordState extends AuthState {
  final bool showPassword;
  LoginShowPasswordState({required this.showPassword});
  @override
  List<Object?> get props => [showPassword];
}
