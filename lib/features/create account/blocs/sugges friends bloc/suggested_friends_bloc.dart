import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flock/models/user.dart';

part 'suggested_friends_event.dart';
part 'suggested_friends_state.dart';

class SuggestedFriendsBloc extends Bloc<SuggestedFriendsEvent, SuggestedFriendsState> {
  SuggestedFriendsBloc() : super(SuggestedFriendsInitial()) {
    on<SuggestedFriendsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
