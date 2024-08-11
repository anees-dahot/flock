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
    on<CreateAccountFunction>(createAccountFunction);
  }

  FutureOr<void> createAccountFunction(
      CreateAccountFunction event, Emitter<CreateAccountState> emit) async {
    emit(CreateAccountLoadingState());
    try {
      final response = await createAccountRepository.createAccount(
          event.fullName,
          event.userName,
          event.bio,
          event.profileImage,
          event.phoneNumber,
          event.dateOfBirth);

      if (response['status'] == 200) {
        emit(
          CreateAccountSuccessState(
            message: response['message'],
          ),
        );
      } else if (response['status'] == 400) {
        emit(
          CreateAccountFailureState(
            error: response['msg'],
          ),
        );
      } else if (response['status'] == 500) {
        emit(
          CreateAccountFailureState(
            error: response['error'],
          ),
        );
      } else {
        emit(
          CreateAccountFailureState(
            error: response['error'],
          ),
        );
      }
    } catch (e) {
      emit(CreateAccountFailureState(error: e.toString()));
    }
  }
}
