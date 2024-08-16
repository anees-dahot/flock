part of 'friend_requests_bloc.dart';

sealed class FriendRequestsEvent extends Equatable {
  const FriendRequestsEvent();

  @override
  List<Object> get props => [];
}

class GetFriendRequestsEvent extends FriendRequestsEvent {}

class AcceptFriendRequestsEvent extends FriendRequestsEvent {
  final String userId;

  const AcceptFriendRequestsEvent({required this.userId});
  @override
  List<Object> get props => [userId];
}

class DeleteFriendRequestsEvent extends FriendRequestsEvent {
  final String userId;

  const DeleteFriendRequestsEvent({required this.userId});
  @override
  List<Object> get props => [userId];
}
