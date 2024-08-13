import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flock/features/create%20account/repository/suggested_friends_repositoy.dart';
import 'package:flock/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'suggested_friends_event.dart';
part 'suggested_friends_state.dart';

class SuggestedFriendsBloc
    extends Bloc<SuggestedFriendsEvent, SuggestedFriendsState> {
  final List<String> sentRequestIds = [];
  final List<UserModel> suggestedFriends = [];
  final SuggestedFriendsRepository suggestedFriendsRepository;
  final int maxRequests = 5;
  int currentRequestCount = 0;
  late SharedPreferences _prefs;

  SuggestedFriendsBloc({required this.suggestedFriendsRepository})
      : super(SuggestedFriendsInitial()) {
    on<GetSuggestedFriendsEvent>(getSuggestedFriendsEvent);
    on<SendFriendRequestEvent>(sendFriendRequestEvent);
    on<DeleteFriendRequestEvent>(deleteFriendRequestEvent);
    on<CheckFriendRequestStatusEvent>(checkFriendRequestStatus);
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadSentRequestIds();
  }

  void _loadSentRequestIds() {
    sentRequestIds.clear();
    sentRequestIds.addAll(_prefs.getStringList('sentRequestIds') ?? []);
    currentRequestCount = sentRequestIds.length;
  }

  Future<void> _saveSentRequestIds() async {
    await _prefs.setStringList('sentRequestIds', sentRequestIds);
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
    emit(SendFriendRequestSuccessState());

    try {
      final response =
          await suggestedFriendsRepository.sendFriendRequest(event.userId);

      if (response['status'] == 200) {
        sentRequestIds.add(event.userId);
        currentRequestCount = sentRequestIds.length;
        await _saveSentRequestIds();

        emit(SuggestedFriendsSuccessState(
            suggestedFriends: List.from(suggestedFriends)));
      } else {
        emit(SuggestedFriendsFailureState(error: response['message']));
      }
    } catch (e) {
      emit(SuggestedFriendsFailureState(error: e.toString()));
    }
  }

  Future<void> deleteFriendRequestEvent(DeleteFriendRequestEvent event,
      Emitter<SuggestedFriendsState> emit) async {
    emit(SendFriendRequestSuccessState());

    try {
      final response =
          await suggestedFriendsRepository.deleteFriendRequest(event.userId);

      if (response['status'] == 200) {
        sentRequestIds.removeWhere((element) => element == event.userId);
        currentRequestCount = sentRequestIds.length;
        await _saveSentRequestIds();

        emit(SuggestedFriendsSuccessState(
            suggestedFriends: List.from(suggestedFriends)));
      } else {
        emit(SuggestedFriendsFailureState(error: response['message']));
      }
    } catch (e) {
      emit(SuggestedFriendsFailureState(error: e.toString()));
    }
  }

  Future<void> checkFriendRequestStatus(CheckFriendRequestStatusEvent event,
      Emitter<SuggestedFriendsState> emit) async {
    try {
      final response = await suggestedFriendsRepository
          .checkFriendRequestStatus(event.userId);
      if (response['status'] == 200) {
        emit(FriendRequestStatusState(isRequestSent: response['data']));
      }
    } catch (e) {
      emit(SuggestedFriendsFailureState(error: e.toString()));
    }
  }
}
