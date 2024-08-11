part of 'create_account_bloc.dart';

sealed class CreateAccountState extends Equatable {
  const CreateAccountState();

  @override
  List<Object> get props => [];
}

final class CreateAccountInitial extends CreateAccountState {}

class CreateAccountLoadingState extends CreateAccountState {}

class CreateAccountSuccessState extends CreateAccountState {
  final String message;

  const CreateAccountSuccessState({required this.message});
  @override
  List<Object> get props => [message];
}

class CreateAccountFailureState extends CreateAccountState {
  final String error;

  const CreateAccountFailureState({required this.error});
  @override
  List<Object> get props => [error];
}
