

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flock/features/create%20account/repository/create_account_repository.dart';

part 'create_account_event.dart';
part 'create_account_state.dart';

class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
  final CreateAccountRepository createAccountRepository;
  CreateAccountBloc(this.createAccountRepository)
      : super(CreateAccountInitial()) {}
}
