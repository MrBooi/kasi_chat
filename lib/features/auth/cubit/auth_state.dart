part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class Initial extends AuthState {}

final class Loading extends AuthState {}

final class Authenticated extends AuthState {
  const Authenticated(this.user);
  final User user;

  @override
  List<Object> get props => [user];
}

final class Unauthenticated extends AuthState {}

final class AuthError extends AuthState {
  const AuthError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
