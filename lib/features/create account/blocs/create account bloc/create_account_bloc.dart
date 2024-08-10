import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flock/features/create%20account/repository/create_account_repository.dart';

part 'create_account_event.dart';
part 'create_account_state.dart';

class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
  final CreateAccountRepository createAccountRepository;
  CreateAccountBloc(this.createAccountRepository)
      : super(CreateAccountInitial()) {
    on<CreateAccount>(createAccount);
  }

  FutureOr<void> createAccount(
      CreateAccount event, Emitter<CreateAccountState> emit) async {
    emit(CreateAccountLoadingState());
    try {
      final respose = await createAccountRepository.createAccount(
          email: event.email, password: event.password);
      if (respose['status'] == 200) {
        emit(CreateAccountSuccessState(message: respose['message']));
      } else if (respose['status'] == 400) {
        emit(CreateAccountSuccessState(message: respose['message']));
      } else {
        emit(CreateAccountSuccessState(message: respose['message']));
      }
    } catch (e) {
      emit(CreateAccountFailureState(message: e.toString()));
    }
  }
}
