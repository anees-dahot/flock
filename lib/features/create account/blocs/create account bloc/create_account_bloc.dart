import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_account_event.dart';
part 'create_account_state.dart';

class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
  CreateAccountBloc() : super(CreateAccountInitial()) {
    on<CreateAccountEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
