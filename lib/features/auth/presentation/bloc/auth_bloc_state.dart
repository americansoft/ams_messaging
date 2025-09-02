part of 'auth_bloc.dart';

@immutable
abstract class AuthBlocState extends Equatable { 
  final UserEntity? userEntity;
  final DioException? error;
  


  const AuthBlocState({this.userEntity,this.error});

  @override
  List<Object?> get props => [userEntity,error];

}

class AuthInitial extends AuthBlocState {
  const AuthInitial();
}

final class AuthLoading extends AuthBlocState  {
  const AuthLoading();
}

final class AuthAuthenticated extends AuthBlocState {
   const AuthAuthenticated(UserEntity userEntity):super(userEntity: userEntity);
}
final class AuthUnauthenticated  extends AuthBlocState {
    const AuthUnauthenticated ();

}
class AuthFail extends AuthBlocState {
  const AuthFail(DioException error):super(error: error);
}
