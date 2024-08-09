// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'image_picker_bloc.dart';

sealed class ImagePickerState extends Equatable {
  const ImagePickerState();

  @override
  List<Object> get props => [];
}

final class ImagePickerInitial extends ImagePickerState {}

class LoadingState extends ImagePickerState {}

class ErrorState extends ImagePickerState {
  final String error;

 const ErrorState({required this.error});
}

class SuccessState extends ImagePickerState {
  final XFile? image;
  const SuccessState({
    required this.image,
  });
}
