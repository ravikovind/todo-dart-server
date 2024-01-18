import 'dart:async';

import 'package:client/core/utils/constants.dart';
import 'package:client/data/models/user.dart';
import 'package:client/data/repositories/auth_repository.dart';
import 'package:client/features/user/user_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.repository,
    required this.userBloc,
  }) : super(const AuthState()) {
    on<SignUpEvent>(_onSignUp);
    on<SignInEvent>(_onSignIn);
    on<SignOutEvent>(_onSignOut);
  }

  final AuthRepository repository;
  final UserBloc userBloc;

  FutureOr<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(
        message: '',
        error: '',
        busy: true,
      ));
      final response = await repository.signUp(
        user: event.user,
      );
      if (response.success) {
        final user = response.data as User;
        await HydratedBloc.storage.write(
          kToken,
          user.accessToken,
        );
        userBloc.add(UpdateUser(user: user));
        emit(state.copyWith(
          message: response.message,
          busy: false,
        ));
      } else {
        emit(state.copyWith(
          error: response.message,
          busy: false,
        ));
      }
    } catch (_) {
      emit(
        state.copyWith(
          error: 'An unknown error occurred',
          busy: false,
        ),
      );
    }
  }

  FutureOr<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(
        message: '',
        error: '',
        busy: true,
      ));
      final response = await repository.signIn(
        user: event.user,
      );
      if (response.success) {
        final user = response.data as User;
        await HydratedBloc.storage.write(
          kToken,
          user.accessToken,
        );
        userBloc.add(UpdateUser(user: user));
        emit(state.copyWith(
          message: response.message,
          busy: false,
        ));
      } else {
        emit(state.copyWith(
          error: response.message,
          busy: false,
        ));
      }
    } catch (_) {
      emit(
        state.copyWith(
          error: 'An unknown error occurred',
          busy: false,
        ),
      );
    }
  }

  FutureOr<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    userBloc.add(const ClearUser());
    emit(const AuthState());
  }
}
