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

class EmailAlreadyExistsFailure extends Failure {
  const EmailAlreadyExistsFailure() : super('Email is exists');
}

class PhoneNumberExistsFailure extends Failure {
  const PhoneNumberExistsFailure() : super('Phone Number is exists');
}

class UnexpectedError extends Failure {
  const UnexpectedError(super.message);
}

class UserRegisterError extends Failure {
  final String message;
  const UserRegisterError({required this.message}) : super(message);
}

class UserSignInFailure extends Failure {
  final String message;
  const UserSignInFailure({required this.message}) : super(message);
}
