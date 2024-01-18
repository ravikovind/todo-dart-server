part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.busy = false,
    this.error = '',
    this.message = '',
  });
  final bool busy;
  final String error;
  final String message;

  /// copyWith is a method that returns a new instance of the [AuthState] with
  /// the updated values.
  AuthState copyWith({
    bool? busy,
    String? error,
    String? message,
  }) {
    return AuthState(
      busy: busy ?? this.busy,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [busy, error, message];
}
