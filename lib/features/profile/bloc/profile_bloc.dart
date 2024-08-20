import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flock/features/profile/repository/profile_repository.dart';
import 'package:flock/models/user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository profileRepository;
  ProfileBloc({required this.profileRepository}) : super(ProfileInitial()) {
    on<GetFriendRequestsEvent>(getFriendRequests);
  }

  FutureOr<void> getFriendRequests(
      GetFriendRequestsEvent event, Emitter<ProfileState> emit) async {
    emit(GetFriendRequestsLoadingState());
    try {
      final response = await profileRepository.getFriendRequests();
      if (response['status'] == 200) {
        emit(GetFriendRequestsSuccessState(friendRequests: response['data']));
      } else if (response['status'] == 400) {
        emit(GetFriendRequestsFailureState(error: response['message']));
      } else if (response['status'] == 500) {
        emit(GetFriendRequestsFailureState(error: response['message']));
      } else {
        emit(GetFriendRequestsFailureState(error: response['message']));
      }
    } catch (e) {
      emit(GetFriendRequestsFailureState(error: e.toString()));
      print(e.toString());
    }
  }
}
