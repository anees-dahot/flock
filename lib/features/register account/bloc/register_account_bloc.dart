import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flock/features/register%20account/repository/register_account_repository.dart';

part 'register_account_event.dart';
part 'register_account_state.dart';

class RegisterAccountBloc
    extends Bloc<RegisterAccountEvent, RegisterAccountState> {
  final RegisterAccountRepository registerAccountRepository;
  RegisterAccountBloc(this.registerAccountRepository)
      : super(RegisterAccountInitial()) {
    on<RegisterAccountFunction>(registerAccountFunction);
  }

  FutureOr<void> registerAccountFunction(
      RegisterAccountFunction event, Emitter<RegisterAccountState> emit) async {
    emit(RegisterAccountLoadingState());
    try {
      final respose = await registerAccountRepository.registerAccount(
          email: event.email, password: event.password);
      if (respose['status'] == 200) {
        emit(RegisterAccountSuccessState(message: respose['message']));
      } else if (respose['status'] == 400) {
        emit(RegisterAccountSuccessState(message: respose['message']));
      } else {
        emit(RegisterAccountSuccessState(message: respose['message']));
      }
    } catch (e) {
      emit(RegisterAccountFailureState(message: e.toString()));
    }
  }
}
