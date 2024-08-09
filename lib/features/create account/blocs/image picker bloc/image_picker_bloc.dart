import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flock/utils/image_picker.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc() : super(ImagePickerInitial()) {
    on<PickImageFromGallery>(pickImageFromGallery);
  }

  FutureOr<void> pickImageFromGallery(
      PickImageFromGallery event, Emitter<ImagePickerState> emit) async {
    emit(LoadingState());
    try {
      final XFile? image = await Utils.pickImage();
      emit(SuccessState(image: image));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
