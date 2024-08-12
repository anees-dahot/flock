part of 'create_account_bloc.dart';

sealed class CreateAccountEvent extends Equatable {
  const CreateAccountEvent();

  @override
  List<Object> get props => [];
}

class CreateAccountFunction extends CreateAccountEvent {
  final String fullName;
  final String userName;
  final String profileImage;
  final String profileCover;
  final String bio;
  final DateTime dateOfBirth;
  final int phoneNumber;

  const CreateAccountFunction(
      {required this.fullName,
      required this.userName,
      required this.profileImage,
      required this.profileCover,
      required this.bio,
      required this.dateOfBirth,
      required this.phoneNumber});

  @override
  List<Object> get props => [
        fullName,
        userName,
        profileImage,
        profileCover,
        bio,
        dateOfBirth,
        phoneNumber
      ];
}
