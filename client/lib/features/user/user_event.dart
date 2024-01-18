part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object> get props => [];
}

class ConfirmAuth extends UserEvent {
  const ConfirmAuth();
  @override
  List<Object> get props => [];
}

class UpdateUser extends UserEvent {
  const UpdateUser({
    required this.user,
  });
  final User user;
  @override
  List<Object> get props => [user];
}

class ClearUser extends UserEvent {
  const ClearUser();
  @override
  List<Object> get props => [];
}
