part of 'auth_bloc.dart';

@immutable
abstract class AuthBlocEvent {
  final AuthParams? authParams;
  const AuthBlocEvent({this.authParams});
}

final class LogoutEvent extends AuthBlocEvent {
const LogoutEvent();
}

final class LoginEvent extends AuthBlocEvent {
  const LoginEvent(AuthParams authParams):super(authParams: authParams);
}
