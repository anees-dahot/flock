part of 'create_account_bloc.dart';

sealed class CreateAccountEvent extends Equatable {
  const CreateAccountEvent();

  @override
  List<Object> get props => [];
}

class CreateAccount extends CreateAccountEvent {
  final String email;
  final String password;

  const CreateAccount({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}
