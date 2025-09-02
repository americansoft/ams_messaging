
import 'package:ams_messaging/core/network/http_results.dart';
import 'package:ams_messaging/features/auth/data/models/auth_params.dart';
import 'package:ams_messaging/features/auth/domain/entities/user.dart';
import 'package:ams_messaging/features/auth/domain/usecases/login_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import'package:equatable/equatable.dart';


part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final LoginUseCase _loginUseCase;
  AuthBloc(this._loginUseCase) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<LogoutEvent>(_onLogoutEvent);
}
void _onLoginEvent(LoginEvent event,Emitter<AuthBlocState> emit) async {
  final result = await _loginUseCase(event.authParams!);
  if(result is ResultSuccess){
    emit(AuthAuthenticated(UserEntity.fromUser(result.data)));
  } else {
    emit(AuthFail(result.error!));
  }
}
void _onLogoutEvent(LogoutEvent event,Emitter<AuthBlocState> emit){
  emit(AuthUnauthenticated());
}
}
