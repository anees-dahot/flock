part of 'suggested_friends_bloc.dart';

sealed class SuggestedFriendsEvent extends Equatable {
  const SuggestedFriendsEvent();

  @override
  List<Object> get props => [];
}

class GetSuggestedFriendsEvent extends SuggestedFriendsEvent {}
