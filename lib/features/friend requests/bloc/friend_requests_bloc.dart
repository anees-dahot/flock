import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flock/features/friend%20requests/repository/friend_requests_repository.dart';

import '../../../models/user.dart';

part 'friend_requests_event.dart';
part 'friend_requests_state.dart';

class FriendRequestsBloc
    extends Bloc<FriendRequestsEvent, FriendRequestsState> {
  FriendRequestsRepository friendRequestsRepository;
  FriendRequestsBloc({required this.friendRequestsRepository})
      : super(FriendRequestsInitial()) {
    on<GetFriendRequestsEvent>(getFriendRequestsEvent);
  }

  FutureOr<void> getFriendRequestsEvent(
      GetFriendRequestsEvent event, Emitter<FriendRequestsState> emit) async {
    emit(GetFriendRequestsLoadingState());
    try {
      final response = await friendRequestsRepository.getFriendRequests();
      if (response['status'] == 200) {
        emit(GetFriendRequestsSuccessState(friendRequests: response['data']));
      } else if (response['status'] == 400) {
        emit(GetFriendRequestsFailureState(error: response['message']));
      } else if (response['status'] == 500) {
        emit(GetFriendRequestsFailureState(error: response['message']));
      } else {
        emit(GetFriendRequestsFailureState(error: response['message']));
      }
    } catch (e) {
      emit(GetFriendRequestsFailureState(error: e.toString()));
    }
  }
}
