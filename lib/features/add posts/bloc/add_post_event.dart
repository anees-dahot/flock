part of 'add_post_bloc.dart';

sealed class AddPostEvent extends Equatable {
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

class AddPost extends AddPostEvent {
  final String postText;
  final List<String> postImages;
  final List<String> postVideos;
  final String privacy;

  const AddPost(
      {required this.postText,
      required this.postImages,
      required this.postVideos,
      required this.privacy});
  @override
  List<Object> get props => [postText, postImages, postVideos, privacy];
}
