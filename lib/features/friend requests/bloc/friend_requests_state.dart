part of 'friend_requests_bloc.dart';

sealed class FriendRequestsState extends Equatable {
  const FriendRequestsState();

  @override
  List<Object> get props => [];
}

final class FriendRequestsInitial extends FriendRequestsState {}

class GetFriendRequestsLoadingState extends FriendRequestsState {}

class GetFriendRequestsSuccessState extends FriendRequestsState {
  final List<UserModel> friendRequests;

  const GetFriendRequestsSuccessState({required this.friendRequests});
  @override
  List<Object> get props => [friendRequests];
}

class GetFriendRequestsStateState extends FriendRequestsState {
  final String error;

  const GetFriendRequestsStateState({required this.error});
  @override
  List<Object> get props => [error];
}
