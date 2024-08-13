import 'package:cached_network_image/cached_network_image.dart';
import 'package:flock/features/create%20account/blocs/sugges%20friends%20bloc/suggested_friends_bloc.dart';
import 'package:flock/features/create%20account/repository/suggested_friends_repositoy.dart';
import 'package:flock/models/user.dart';
import 'package:flock/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuggestedFriends extends StatefulWidget {
  static const String routeName = 'add-suggested-friends';
  const SuggestedFriends({super.key});

  @override
  State<SuggestedFriends> createState() => _SuggestedFriendsState();
}

class _SuggestedFriendsState extends State<SuggestedFriends> {
  late SuggestedFriendsBloc _suggestedFriendsBloc;
  String? id;

  @override
  void initState() {
    _suggestedFriendsBloc = SuggestedFriendsBloc(
        suggestedFriendsRepository: SuggestedFriendsRepository());
    _suggestedFriendsBloc.add(GetSuggestedFriendsEvent());
    assignIt();
    super.initState();
  }

  void assignIt() async {
    await Storage().getUserData().then((value) {
      id = value!.id;
    });
    print(id);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => _suggestedFriendsBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Friends',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: Column(
          children: [
            SizedBox(height: height * 0.05),
            Text(
              'Suggested Friends',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Add at least 5 friends to get started!',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(height: height * 0.05),
            BlocConsumer<SuggestedFriendsBloc, SuggestedFriendsState>(
              bloc: _suggestedFriendsBloc,
              buildWhen: (previous, current) => current is! FriendRequestState,
              listener: (context, state) {
                // Handle any additional logic if needed
              },
              builder: (context, state) {
                if (state is SuggestedFriendsLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is SuggestedFriendsFailureState) {
                  return Center(child: Text(state.error));
                } else if (state is SuggestedFriendsSuccessState) {
                  if (state.suggestedFriends.isEmpty) {
                    return const Center(child: Text('No friends available'));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.suggestedFriends.length,
                        itemBuilder: (context, index) {
                          var data = state.suggestedFriends[index];
                          bool isRequestSent = _suggestedFriendsBloc
                              .sentRequestIds
                              .contains(data.id);

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Card(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: ListTile(
                                  leading: SizedBox(
                                    width: 45,
                                    height: 45,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                        imageUrl: data.profileImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  title: Text(data.fullName),
                                  trailing: BlocBuilder<SuggestedFriendsBloc,
                                      SuggestedFriendsState>(
                                    bloc: _suggestedFriendsBloc,
                                    buildWhen: (previous, current) =>
                                        current is FriendRequestState,
                                    builder: (context, state) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (!isRequestSent) {
                                            _suggestedFriendsBloc.add(
                                                SendFriendRequestEvent(
                                                    userId: data.id));
                                          } else {}
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                          decoration: BoxDecoration(
                                            color: isRequestSent ||
                                                    data.friendsRequests
                                                        .contains(id)
                                                ? Theme.of(context)
                                                        .colorScheme
                                                        .onBackground // Change color if request is sent or already requested
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Center(
                                            child: Text(
                                              isRequestSent
                                                  ? 'Requested'
                                                  : data.friendsRequests
                                                          .contains(id)
                                                      ? 'Requested' // Change text if already requested
                                                      : 'Add Friend',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: isRequestSent ||
                                                        data.friendsRequests
                                                            .contains(id)
                                                    ? Theme.of(context).colorScheme.background // Change texst color for both conditions
                                                    : const Color.fromARGB(
                                                        255, 29, 29, 29),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                } else {
                  return const Center(
                    child: Text('No data'),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
