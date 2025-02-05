import 'package:equatable/equatable.dart';

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

class LoginShowPasswordState extends AuthState {
  final bool showPassword;
  LoginShowPasswordState({required this.showPassword});
  @override
  List<Object?> get props => [showPassword];
}
