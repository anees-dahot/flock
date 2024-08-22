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
