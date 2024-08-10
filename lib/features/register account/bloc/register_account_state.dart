part of 'register_account_bloc.dart';

sealed class RegisterAccountState extends Equatable {
  const RegisterAccountState();

  @override
  List<Object> get props => [];
}

final class RegisterAccountInitial extends RegisterAccountState {}

class RegisterAccountLoadingState extends RegisterAccountState {}

class RegisterAccountSuccessState extends RegisterAccountState {
  final String message;

  const RegisterAccountSuccessState({required this.message});
  @override
  List<Object> get props => [message];
}

class RegisterAccountFailureState extends RegisterAccountState {
  final String message;

  const RegisterAccountFailureState({required this.message});
  @override
  List<Object> get props => [message];
}
