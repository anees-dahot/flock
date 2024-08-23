import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flock/features/add%20posts/repository/add_post_repository.dart';
import 'package:flock/utils/image_picker.dart';
import 'package:image_picker/image_picker.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  List<String> images = [];
  String visibilityType = '';
  AddPostRepository addPostRepository;
  AddPostBloc({required this.addPostRepository}) : super(AddPostInitial()) {
    on<PickPostImagesEvent>(pickPostImagesEvent);
    on<ChoosePostVisibilityEvent>(choosePostVisibilityEvent);
    on<AddPostFunction>(addPost);
  }

  FutureOr<void> pickPostImagesEvent(
      PickPostImagesEvent event, Emitter<AddPostState> emit) async {
    emit(PickPostImagesLoadingState());
    try {
      final List<XFile>? selectedImage = await Utils.pickMultipleImages();
      selectedImage?.map((e) => images.add(e.path));
      emit(PickPostImagesSuccessState(
          images: selectedImage?.map((image) => image.path).toList() ?? []));
    } catch (e) {
      emit(PickPostImagesFailureState(error: e.toString()));
    }
  }

  FutureOr<void> choosePostVisibilityEvent(
      ChoosePostVisibilityEvent event, Emitter<AddPostState> emit) {
    visibilityType = event.visibilityType;
    emit(
        ChoosePostVisibilitySuccessState(visibilityType: event.visibilityType));
  }

  FutureOr<void> addPost(AddPostFunction event, Emitter<AddPostState> emit) async {
    emit(AddPostLoadingState());
    try {
      final response = await addPostRepository.addPost(
          postText: event.postText,
          postImages: event.postImages,
          postVideos: event.postVideos,
          privacy: event.privacy);
      if (response['status'] == 200) {
        emit(AddPostSucccessState(message: response['message']));
      } else if (response['status'] == 400) {
        emit(AddPostFailureState(error: response['message']));
      } else if (response['status'] == 500) {
        emit(AddPostFailureState(error: response['message']));
      } else {
        emit(AddPostFailureState(error: response['message']));
      }
    } catch (e) {
      emit(AddPostFailureState(error: e.toString()));
    }
  }
}
