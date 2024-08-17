import 'package:flock/features/friend%20requests/bloc/friend_requests_bloc.dart';
import 'package:flock/features/friend%20requests/repository/friend_requests_repository.dart';
import 'package:flock/features/profile/screens/profile_screen.dart';
import 'package:flock/utils/flush_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendRequests extends StatefulWidget {
  const FriendRequests({super.key});

  @override
  State<FriendRequests> createState() => _FriendRequestsState();
}

class _FriendRequestsState extends State<FriendRequests> {
  late FriendRequestsBloc _friendRequestsBloc;
  @override
  void initState() {
    _friendRequestsBloc = FriendRequestsBloc(
        friendRequestsRepository: FriendRequestsRepository());
    _friendRequestsBloc.add(GetFriendRequestsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => _friendRequestsBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Friend Requests',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: BlocConsumer<FriendRequestsBloc, FriendRequestsState>(
          listenWhen: (previous, current) =>
              current is FriendRequestActionState,
          buildWhen: (previous, current) =>
              current is! FriendRequestActionState,
          listener: (context, state) {
            if (state is AccpetFriendRequestsSuccessState) {
              NotificationHelper.showSuccessNotification(
                  context, state.message);
            } else if (state is AcceptFriendRequestsFailureState) {
              NotificationHelper.showErrorNotification(context, state.error);
            } else if (state is DeleteFriendRequestsSuccessState) {
              NotificationHelper.showSuccessNotification(
                  context, state.message);
            } else if (state is DeleteFriendRequestsFailureState) {
              NotificationHelper.showErrorNotification(context, state.error);
            }
          },
          bloc: _friendRequestsBloc,
          builder: (context, state) {
            if (state is GetFriendRequestsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetFriendRequestsFailureState) {
              return Center(
                child: Text(state.error),
              );
            } else if (state is GetFriendRequestsSuccessState) {
              if (state.friendRequests.isEmpty) {
                return const Center(
                  child: Text('no data'),
                );
              } else {
                return Center(
                  child: ListView.builder(
                      itemCount: state.friendRequests.length,
                      itemBuilder: (context, index) {
                        final requests = state.friendRequests[index];
                        return Container(
                          width: size.width * 0.9,
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.of(context).pushNamed(
                                    ProfileScreen.routeName,
                                    arguments: requests),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          NetworkImage(requests.profileImage),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            requests.fullName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _friendRequestsBloc.add(
                                          AcceptFriendRequestsEvent(
                                              userId: requests.id));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      'Accept',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      _friendRequestsBloc.add(
                                          DeleteFriendRequestsEvent(
                                              userId: requests.id));
                                    },
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      side: BorderSide(
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                    ),
                                    child: Text(
                                      'Delete',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                );
              }
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          },
        ),
      ),
    );
  }
}
