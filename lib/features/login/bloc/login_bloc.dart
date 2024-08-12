import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flock/features/login/repositories/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository loginRepository;
  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {
    on<LoginFunctionEvent>(loginFunctionEvent);
  }

  FutureOr<void> loginFunctionEvent(
      LoginFunctionEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      final response = await loginRepository.login(event.email, event.password);
      if (response['status'] == 200) {
        emit(LoginSuccessState(message: response['message']));
      } else if (response['status'] == 400) {
        emit(LoginFailureState(error: response['message']));
      } else if (response['status'] == 500) {
        emit(LoginFailureState(error: response['message']));
      } else {
        emit(LoginFailureState(error: response['message']));
      }
    } catch (e) {
      emit(LoginFailureState(error: e.toString()));
    }
  }
}
