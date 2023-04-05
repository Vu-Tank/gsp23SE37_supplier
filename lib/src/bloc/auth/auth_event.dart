part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthEvent {}

class UserLoggedIn extends AuthEvent {
  final MyUser.User user;
  const UserLoggedIn({required this.user});

  @override
  List<Object> get props => [user];
}

class UserLoggedOut extends AuthEvent {
  final MyUser.User user;
  const UserLoggedOut(this.user);

  @override
  List<Object> get props => [user];
}

class UserUpdate extends AuthEvent {
  final MyUser.User user;
  const UserUpdate(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [user];
}
