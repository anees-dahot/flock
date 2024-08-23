import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flock/utils/image_picker.dart';
import 'package:image_picker/image_picker.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  List<String> images = [];
  String visibilityType = '';
  AddPostBloc() : super(AddPostInitial()) {
    on<PickPostImagesEvent>(pickPostImagesEvent);
    on<ChoosePostVisibilityEvent>(choosePostVisibilityEvent);
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
}
