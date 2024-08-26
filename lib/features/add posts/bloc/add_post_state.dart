part of 'add_post_bloc.dart';

abstract class AddPostState extends Equatable {
  final List<String> images;
  final String visibilityType;
  
  const AddPostState({
    this.images = const [],
    this.visibilityType = 'Public',
  });

  @override
  List<Object> get props => [images, visibilityType];
}

class AddPostInitial extends AddPostState {}

class AddPostLoading extends AddPostState {}

class AddPostImagesUpdated extends AddPostState {
  final List<String> images;

  const AddPostImagesUpdated({required this.images}) : super(images: images);

  @override
  List<Object> get props => [images];
}

class AddPostVisibilityChanged extends AddPostState {
  final String visibilityType;

  const AddPostVisibilityChanged({required this.visibilityType}) : super(visibilityType: visibilityType);

  @override
  List<Object> get props => [visibilityType];
}

class AddPostSuccess extends AddPostState {
  final String message;

  const AddPostSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class AddPostError extends AddPostState {
  final String error;

  const AddPostError({required this.error});

  @override
  List<Object> get props => [error];
}