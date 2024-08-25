import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flock/features/add%20posts/repository/add_post_repository.dart';
import 'package:flock/utils/image_picker.dart';
import 'package:image_picker/image_picker.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
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
      emit(PickPostImagesSuccessState(
          images: selectedImage!.map((e) => e.path).toList()));
    } catch (e) {
      emit(PickPostImagesFailureState(error: e.toString()));
    }
  }

  FutureOr<void> choosePostVisibilityEvent(
      ChoosePostVisibilityEvent event, Emitter<AddPostState> emit) {
    emit(
        ChoosePostVisibilitySuccessState(visibilityType: event.visibilityType));
  }

  FutureOr<void> addPost(
      AddPostFunction event, Emitter<AddPostState> emit) async {
    emit(AddPostLoadingState());
    try {
      final response = await addPostRepository.addPost(
          postText: event.postText,
          postImages: event.postImages,
          postVideos: event.postVideos,
          privacy: event.privacy);
      if (response['status'] == 200) {
        emit(AddPostSucccessState(message: response['message']));
        print(response['message']);
      } else if (response['status'] == 400) {
        emit(AddPostFailureState(error: response['message']));
        print(response['message']);
      } else if (response['status'] == 500) {
        emit(AddPostFailureState(error: response['message']));
        print(response['message']);
      } else {
        emit(AddPostFailureState(error: response['message']));
        print(response['message']);
      }
    } catch (e) {
      emit(AddPostFailureState(error: e.toString()));
      print(e.toString());
    }
  }
}
