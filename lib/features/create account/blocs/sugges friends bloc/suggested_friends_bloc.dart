// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flock/features/create%20account/repository/suggested_friends_repositoy.dart';
import 'package:flock/models/user.dart';

part 'suggested_friends_event.dart';
part 'suggested_friends_state.dart';

class SuggestedFriendsBloc
    extends Bloc<SuggestedFriendsEvent, SuggestedFriendsState> {
  SuggestedFriendsRepository suggestedFriendsRepository;
  SuggestedFriendsBloc({
    required this.suggestedFriendsRepository,
  }) : super(SuggestedFriendsInitial()) {
    on<GetSuggestedFriendsEvent>(getSuggestedFriendsEvent);
    on<SendFriendRequestEvent>(sendFriendRequestEvent);
  }

  FutureOr<void> getSuggestedFriendsEvent(GetSuggestedFriendsEvent event,
      Emitter<SuggestedFriendsState> emit) async {
    emit(SuggestedFriendsLoadingState());
    try {
      final response = await suggestedFriendsRepository.getSuggestedFriends();
      if (response['status'] == 200) {
        emit(SuggestedFriendsSuccessState(suggestedFriends: response['data']));
      } else if (response['status'] == 400) {
        emit(SuggestedFriendsFailureState(error: response['message']));
      } else if (response['status'] == 500) {
        emit(SuggestedFriendsFailureState(error: response['message']));
      } else {
        emit(SuggestedFriendsFailureState(error: response['message']));
      }
    } catch (e) {
      emit(SuggestedFriendsFailureState(error: e.toString()));
    }
  }

  FutureOr<void> sendFriendRequestEvent(
      SendFriendRequestEvent event, Emitter<SuggestedFriendsState> emit) async {
    try {
      final response =
          await suggestedFriendsRepository.sendFriendRequest(event.userId);
      if (response['status'] == 200) {
        emit(SendFriendRequestSuccessState());
      } else if (response['status'] == 400) {
        emit(SendFriendRequestFailureState(error: response['message']));
      } else if (response['status'] == 500) {
        emit(SendFriendRequestFailureState(error: response['message']));
      } else {
        emit(SendFriendRequestFailureState(error: response['message']));
      }
    } catch (e) {
      emit(SendFriendRequestFailureState(error: e.toString()));
    }
  }
}
