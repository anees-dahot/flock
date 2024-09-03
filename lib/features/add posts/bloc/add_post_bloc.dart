import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flock/features/add%20posts/repository/add_post_repository.dart';
import 'package:flock/services/background_service.dart';
import 'package:flock/utils/image_picker.dart';
import 'package:flock/utils/storage.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workmanager/workmanager.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final AddPostRepository addPostRepository;

  AddPostBloc({required this.addPostRepository}) : super(AddPostInitial()) {
    on<PickPostImagesEvent>(_onPickPostImages);
    on<ChoosePostVisibilityEvent>(_onChoosePostVisibility);
    on<AddPostFunction>(_onAddPost);
    on<ResetAddPostState>(_resetAddPostState);
  }

  FutureOr<void> _onPickPostImages(
      PickPostImagesEvent event, Emitter<AddPostState> emit) async {
    emit(AddPostLoading());
    try {
      final List<XFile>? selectedImages = await Utils.pickMultipleImages();
      if (selectedImages != null && selectedImages.isNotEmpty) {
        await Storage().saveList(
            'images', selectedImages.map((image) => image.path).toList());
        final List<String> tyoe =
            await Storage().getList('images') as List<String>;
        print(tyoe.length);
        emit(AddPostImagesUpdated(
            images: selectedImages.map((image) => image.path).toList()));
      } else {
        emit(AddPostInitial());
      }
    } catch (e) {
      emit(AddPostError(error: e.toString()));
    }
  }

  FutureOr<void> _onChoosePostVisibility(
      ChoosePostVisibilityEvent event, Emitter<AddPostState> emit) async {
    await Storage().saveDate('visibilityType', event.visibilityType);
    final String tyoe = await Storage().getData('visibilityType') as String;
    print(tyoe);
    emit(AddPostVisibilityChanged(visibilityType: event.visibilityType));
  }

    FutureOr<void> _onAddPost(AddPostFunction event, Emitter<AddPostState> emit) async {
  emit(AddPostLoading());
  try {
   final service = FlutterBackgroundService();
    // Send data to the background service
    service.invoke(
      'uploadPost', 
      {
        'postText': event.postText,
        'postVideos': event.postVideos,
      }
    );

    print("Background task registered successfully");
    emit(AddPostSuccess(message: "Upload started in background"));
  } catch (e) {
    print("Error in _onAddPost: ${e.toString()}");
    emit(AddPostError(error: e.toString()));
  }
}


  FutureOr<void> _resetAddPostState(
      ResetAddPostState event, Emitter<AddPostState> emit) {
    emit(AddPostInitial());
  }
}
