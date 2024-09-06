part of 'feed_bloc.dart';

sealed class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

final class FeedInitial extends FeedState {}

class GetPostsLoadingState extends FeedState {}

class GetPostsSuccessState extends FeedState {
  final List<Post> posts;

  const GetPostsSuccessState({required this.posts});
  @override
  List<Object> get props => [posts];
}

class GetPostsErrorgState extends FeedState {
  final String error;

  const GetPostsErrorgState({required this.error});
  @override
  List<Object> get props => [error];
}
