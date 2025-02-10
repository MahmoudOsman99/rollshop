import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class UnexpectedError extends Failure {
  const UnexpectedError(super.message);
}

//! Chocks
//! Parts
//! Profile

//! Authentication failures
class EmailAlreadyExistsFailure extends Failure {
  const EmailAlreadyExistsFailure() : super('Email is exists');
}

class PhoneNumberExistsFailure extends Failure {
  const PhoneNumberExistsFailure() : super('Phone Number is exists');
}

class UserRegisterFailure extends Failure {
  final String message;
  const UserRegisterFailure({required this.message}) : super(message);
}

class UserNotFoundFailure extends Failure {
  final String message;
  const UserNotFoundFailure({required this.message}) : super(message);
}

class UserSignInFailure extends Failure {
  final String message;
  const UserSignInFailure({required this.message}) : super(message);
}

class UserEmailOrPasswordFailure extends Failure {
  final String message;
  const UserEmailOrPasswordFailure({required this.message}) : super(message);
}

//! Waiting users to approve failures

class NoWaitingUsersFailure extends Failure {
  const NoWaitingUsersFailure(super.message);
}

class NoWaitingUserFoundedFailure extends Failure {
  const NoWaitingUserFoundedFailure(super.message);
}

class AddWaitingUserFailure extends Failure {
  const AddWaitingUserFailure(super.message);
}
