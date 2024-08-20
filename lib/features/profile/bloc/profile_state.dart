part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

class GetFriendRequestsLoadingState extends ProfileState {}

class GetFriendRequestsSuccessState extends ProfileState {
  final List<UserModel> friendRequests;

  const GetFriendRequestsSuccessState({required this.friendRequests});
  @override
  List<Object> get props => [friendRequests];
}

class GetFriendRequestsFailureState extends ProfileState {
  final String error;

  const GetFriendRequestsFailureState({required this.error});
  @override
  List<Object> get props => [error];
}
