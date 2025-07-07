part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocEvent {}

final class AuthBlocLogoutEvent extends AuthBlocEvent {}

final class AuthBlocLoginEvent extends AuthBlocEvent {
  final UserEntity userEntity;
  AuthBlocLoginEvent(this.userEntity);
}
