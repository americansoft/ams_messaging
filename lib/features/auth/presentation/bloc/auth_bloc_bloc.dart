
import 'package:ams_messaging/features/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBloc() : super(AuthBlocUnauthenticated()) {
    on<AuthBlocLoginEvent>((event, emit) {
      emit(AuthBlocAuthenticated(event.userEntity));
    });
    on<AuthBlocLogoutEvent>((event, emit) {
      emit(AuthBlocUnauthenticated());
    });
    
}
}
