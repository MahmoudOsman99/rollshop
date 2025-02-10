import 'package:equatable/equatable.dart';
import 'package:rollshop/features/users/data/models/user_model.dart';

abstract class UserState extends Equatable {}

class UserInitialState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class AddWaitingUserToApproveSuccessState extends UserState {
  @override
  List<Object?> get props => [];
}

class AddWaitingUserToApproveFailedState extends UserState {
  final String error;
  AddWaitingUserToApproveFailedState({required this.error});
  @override
  List<Object?> get props => [error];
}

class WaitingUsersLoadedSuccessState extends UserState {
  final List<UserModel> waitingUsers;
  WaitingUsersLoadedSuccessState({required this.waitingUsers});
  @override
  List<Object?> get props => [waitingUsers];
}

class WaitingUsersLoadedFailedState extends UserState {
  final String error;
  WaitingUsersLoadedFailedState({required this.error});
  @override
  List<Object?> get props => [error];
}

class IsUserApprovedToSignInState extends UserState {
  final bool isApproved;
  IsUserApprovedToSignInState({required this.isApproved});
  @override
  List<Object?> get props => [isApproved];
}

class UserUpdatedErrorState extends UserState {
  final String error;
  UserUpdatedErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}

class UserUpdatedSuccessState extends UserState {
  // final String error;
  // UserUpdatedSuccessState({required this.error});
  @override
  List<Object?> get props => [];
}
