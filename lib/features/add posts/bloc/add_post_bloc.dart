import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flock/utils/image_picker.dart';
import 'package:image_picker/image_picker.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  AddPostBloc() : super(AddPostInitial()) {
    on<PickPostImagesEvent>(pickPostImagesEvent);
    on<ChoosePostVisibilityEvent>(choosePostVisibilityEvent);
  }

  FutureOr<void> pickPostImagesEvent(
      PickPostImagesEvent event, Emitter<AddPostState> emit) async {
    emit(PickPostImagesLoadingState());
    try {
      final List<XFile>? images = await Utils.pickMultipleImages();
      emit(PickPostImagesSuccessState(
          images: images?.map((image) => image.path).toList() ?? []));
    } catch (e) {
      emit(PickPostImagesFailureState(error: e.toString()));
    }
  }

  FutureOr<void> choosePostVisibilityEvent(
      ChoosePostVisibilityEvent event, Emitter<AddPostState> emit) {
    emit(
        ChoosePostVisibilitySuccessState(visibilityType: event.visibilityType));
  }
}
