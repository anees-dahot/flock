part of 'add_post_bloc.dart';

sealed class AddPostState extends Equatable {
  const AddPostState();

  @override
  List<Object> get props => [];
}

abstract class AddPostActionState extends AddPostState {}

final class AddPostInitial extends AddPostState {}

class PickPostImagesLoadingState extends AddPostState {}

class PickPostImagesSuccessState extends AddPostState {
  final List<String> images;

  const PickPostImagesSuccessState({required this.images});
  @override
  List<Object> get props => [images];
}

class PickPostImagesFailureState extends AddPostState {
  final String error;

  const PickPostImagesFailureState({required this.error});
  @override
  List<Object> get props => [error];
}

class ChoosePostVisibilitySuccessState extends AddPostState {
  final String visibilityType;

  const ChoosePostVisibilitySuccessState({required this.visibilityType});
  @override
  List<Object> get props => [visibilityType];
}

class AddPostLoadingState extends AddPostState {}

class AddPostFailureState extends AddPostActionState {
  final String error;

  AddPostFailureState({required this.error});
  @override
  List<Object> get props => [error];
}

class AddPostSucccessState extends AddPostActionState {
  final String message;

  AddPostSucccessState({required this.message});
  @override
  List<Object> get props => [message];
}
