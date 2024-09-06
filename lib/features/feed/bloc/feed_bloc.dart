import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flock/features/feed/repository/feed_repository.dart';
import 'package:flock/models/post.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedRepository feedRepository;
  FeedBloc({required this.feedRepository}) : super(FeedInitial()) {
    on<GetPostsEvent>(getPosts);
  }

  FutureOr<void> getPosts(GetPostsEvent event, Emitter<FeedState> emit) async {
    emit(GetPostsLoadingState());
    try {
      final response = await feedRepository.getPosts();
      if (response['status'] == 200) {
        emit(GetPostsSuccessState(posts: response['data']));
      } else if (response['status'] == 400) {
        emit(GetPostsErrorgState(error: response['message']));
      } else if (response['status'] == 500) {
        emit(GetPostsErrorgState(error: response['message']));
      } else {
        emit(GetPostsErrorgState(error: response['message']));
      }
    } catch (e) {
      emit(GetPostsErrorgState(error: e.toString()));
    }
  }
}
