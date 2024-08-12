import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flock/features/create%20account/repository/suggested_friends_repositoy.dart';
import 'package:flock/models/user.dart';

part 'suggested_friends_event.dart';
part 'suggested_friends_state.dart';

class SuggestedFriendsBloc
    extends Bloc<SuggestedFriendsEvent, SuggestedFriendsState> {
  final List<String> sentRequestIds = [];
  final List<UserModel> suggestedFriends = [];
  final SuggestedFriendsRepository suggestedFriendsRepository;

  SuggestedFriendsBloc({required this.suggestedFriendsRepository})
      : super(SuggestedFriendsInitial()) {
    on<GetSuggestedFriendsEvent>(getSuggestedFriendsEvent);
    on<SendFriendRequestEvent>(sendFriendRequestEvent);
  }

  Future<void> getSuggestedFriendsEvent(GetSuggestedFriendsEvent event,
      Emitter<SuggestedFriendsState> emit) async {
    emit(SuggestedFriendsLoadingState());
    try {
      final response = await suggestedFriendsRepository.getSuggestedFriends();
      if (response['status'] == 200) {
        suggestedFriends
          ..clear()
          ..addAll(response['data']);
        emit(SuggestedFriendsSuccessState(
            suggestedFriends: List.from(suggestedFriends)));
      } else {
        emit(SuggestedFriendsFailureState(error: response['message']));
      }
    } catch (e) {
      emit(SuggestedFriendsFailureState(error: e.toString()));
    }
  }

  Future<void> sendFriendRequestEvent(
      SendFriendRequestEvent event, Emitter<SuggestedFriendsState> emit) async {
    emit(SendFriendRequestSuccessState()); // Emit loading state

    try {
      final response =
          await suggestedFriendsRepository.sendFriendRequest(event.userId);

      if (response['status'] == 200) {
        sentRequestIds.add(event.userId);

        // Emit the updated list of suggested friends with the updated sentRequestIds
        emit(SuggestedFriendsSuccessState(
            suggestedFriends: List.from(suggestedFriends)));
      } else {
        emit(SuggestedFriendsFailureState(error: response['message']));
      }
    } catch (e) {
      emit(SuggestedFriendsFailureState(error: e.toString()));
    }
  }
}
