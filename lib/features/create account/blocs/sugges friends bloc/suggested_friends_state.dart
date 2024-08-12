part of 'suggested_friends_bloc.dart';

sealed class SuggestedFriendsState extends Equatable {
  const SuggestedFriendsState();

  @override
  List<Object> get props => [];
}

abstract class FriendRequestState extends SuggestedFriendsState {}

final class SuggestedFriendsInitial extends SuggestedFriendsState {}

class SuggestedFriendsLoadingState extends SuggestedFriendsState {}

class SuggestedFriendsSuccessState extends SuggestedFriendsState {
  final List<UserModel> suggestedFriends;

  const SuggestedFriendsSuccessState({required this.suggestedFriends});
  @override
  List<Object> get props => [suggestedFriends];
}

class SuggestedFriendsFailureState extends SuggestedFriendsState {
  final String error;

  const SuggestedFriendsFailureState({required this.error});
  @override
  List<Object> get props => [error];
}

class SendFriendRequestSuccessState extends FriendRequestState {}

class SendFriendRequestFailureState extends FriendRequestState {
  final String error;

  SendFriendRequestFailureState({required this.error});
  @override
  List<Object> get props => [error];
}

class SendFriendRequestLoadingState extends FriendRequestState {}
