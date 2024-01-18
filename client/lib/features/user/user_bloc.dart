import 'dart:async';

import 'package:client/core/utils/constants.dart';
import 'package:client/data/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:string_contains/string_contains.dart';

part 'user_event.dart';

class UserBloc extends HydratedBloc<UserEvent, User> {
  UserBloc() : super(const User()) {
    on<ConfirmAuth>(_onConfirmAuth);
    on<UpdateUser>(_onUpdateUser);
    on<ClearUser>(_onClearUser);
  }
  FutureOr<void> _onConfirmAuth(
      ConfirmAuth event, Emitter<User> emit) async {
    try {
      final accessToken = HydratedBloc.storage.read(kToken)?.toString();
      if (state.id.isNullOrEmpty ||
          state.email.isNullOrEmpty ||
          accessToken.isNullOrEmpty) {
        await HydratedBloc.storage.clear();
        emit(const User());
      }
    } on Exception catch (_) {
      throw Exception(
        'Seems like, you are not authenticated. Please sign in/sing up to continue.',
      );
    }
  }

  Future<void> _onUpdateUser(UpdateUser event, Emitter<User> emit) async {
    emit(event.user);
    add(const ConfirmAuth());
  }

  Future<void> _onClearUser(ClearUser event, Emitter<User> emit) async {
    emit(const User());
    add(const ConfirmAuth());
  }

  @override
  User? fromJson(Map<String, dynamic> json) => User.fromJson(json);

  @override
  Map<String, dynamic>? toJson(User state) => state.toJson();
}
