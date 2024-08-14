import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/user.dart';

part 'friend_requests_event.dart';
part 'friend_requests_state.dart';

class FriendRequestsBloc extends Bloc<FriendRequestsEvent, FriendRequestsState> {
  FriendRequestsBloc() : super(FriendRequestsInitial()) {
    on<FriendRequestsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
