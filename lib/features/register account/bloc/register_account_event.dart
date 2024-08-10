part of 'register_account_bloc.dart';

sealed class RegisterAccountEvent extends Equatable {
  const RegisterAccountEvent();

  @override
  List<Object> get props => [];
}

class RegisterAccountFunction extends RegisterAccountEvent {
  final String email;
  final String password;

  const RegisterAccountFunction({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}
