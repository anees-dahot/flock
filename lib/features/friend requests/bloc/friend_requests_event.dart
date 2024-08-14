part of 'friend_requests_bloc.dart';

sealed class FriendRequestsEvent extends Equatable {
  const FriendRequestsEvent();

  @override
  List<Object> get props => [];
}



class GetFriendRequests extends FriendRequestsEvent{}
