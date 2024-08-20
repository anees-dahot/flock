part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetFriendRequestsEvent extends ProfileEvent {
  final String userId;

 const GetFriendRequestsEvent({required this.userId});
  @override
  List<Object> get props => [userId];
}
