part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String message;

  const LoginSuccessState({required this.message});
  @override
  List<Object> get props => [message];
}

class LoginFailureState extends LoginState {
  final String error;

  const LoginFailureState({required this.error});
  @override
  List<Object> get props => [error];
}
