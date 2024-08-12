part of 'suggested_friends_bloc.dart';

sealed class SuggestedFriendsEvent extends Equatable {
  const SuggestedFriendsEvent();

  @override
  List<Object> get props => [];
}

class GetSuggestedFriendsEvent extends SuggestedFriendsEvent {}

class SendFriendRequestEvent extends SuggestedFriendsEvent {
  final String userId;

  const SendFriendRequestEvent({required this.userId});
  @override
  List<Object> get props => [userId];
}

class CheckFriendRequestStatusEvent extends SuggestedFriendsEvent {
  final String userId;

  const CheckFriendRequestStatusEvent({required this.userId});
  @override
  List<Object> get props => [userId];
}
