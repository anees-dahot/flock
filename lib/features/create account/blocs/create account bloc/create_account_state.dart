part of 'create_account_bloc.dart';

sealed class CreateAccountState extends Equatable {
  const CreateAccountState();
  
  @override
  List<Object> get props => [];
}

final class CreateAccountInitial extends CreateAccountState {}
