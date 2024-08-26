part of 'add_post_bloc.dart';

abstract class AddPostEvent extends Equatable {
  const AddPostEvent();

  @override
  List<Object> get props => [];
}

class PickPostImagesEvent extends AddPostEvent {}

class ChoosePostVisibilityEvent extends AddPostEvent {
  final String visibilityType;

  const ChoosePostVisibilityEvent({required this.visibilityType});

  @override
  List<Object> get props => [visibilityType];
}

class AddPostFunction extends AddPostEvent {
  final String postText;
  final List<String> postVideos;

  const AddPostFunction({
    required this.postText,
    required this.postVideos,
  });

  @override
  List<Object> get props => [postText, postVideos];
}

class ResetAddPostState extends AddPostEvent {}
