part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocState {}


final class AuthBlocLoading extends AuthBlocState {}

final class AuthBlocAuthenticated extends AuthBlocState {
  final UserEntity? userEntity;
  AuthBlocAuthenticated(this.userEntity);
}
final class AuthBlocUnauthenticated extends AuthBlocState {}
