part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

final class SignUpEvent extends AuthEvent {
  const SignUpEvent({
    required this.user,
  });
  final User user;
  @override
  List<Object> get props => [user];
}

final class SignInEvent extends AuthEvent {
  const SignInEvent({
    required this.user,
  });
  final User user;
  @override
  List<Object> get props => [user];
}

final class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}
