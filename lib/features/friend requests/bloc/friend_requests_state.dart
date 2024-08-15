part of 'friend_requests_bloc.dart';

sealed class FriendRequestsState extends Equatable {
  const FriendRequestsState();

  @override
  List<Object> get props => [];
}

abstract class FriendRequestActionState extends FriendRequestsState {}

final class FriendRequestsInitial extends FriendRequestsState {}

class GetFriendRequestsLoadingState extends FriendRequestsState {}

class GetFriendRequestsSuccessState extends FriendRequestsState {
  final List<UserModel> friendRequests;

  const GetFriendRequestsSuccessState({required this.friendRequests});
  @override
  List<Object> get props => [friendRequests];
}

class GetFriendRequestsFailureState extends FriendRequestsState {
  final String error;

  const GetFriendRequestsFailureState({required this.error});
  @override
  List<Object> get props => [error];
}

class AccpetFriendRequestsSuccessState extends FriendRequestActionState {
  final String message;

  AccpetFriendRequestsSuccessState({required this.message});
  @override
  List<Object> get props => [message];
}

class AcceptFriendRequestsFailureState extends FriendRequestActionState {
  final String error;

  AcceptFriendRequestsFailureState({required this.error});
  @override
  List<Object> get props => [error];
}
