import 'package:cached_network_image/cached_network_image.dart';
import 'package:flock/features/create%20account/blocs/sugges%20friends%20bloc/suggested_friends_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuggestedFriendsList extends StatelessWidget {
  const SuggestedFriendsList({
    super.key,
    required SuggestedFriendsBloc suggestedFriendsBloc,
    required this.id,
  }) : _suggestedFriendsBloc = suggestedFriendsBloc;

  final SuggestedFriendsBloc _suggestedFriendsBloc;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuggestedFriendsBloc, SuggestedFriendsState>(
      bloc: _suggestedFriendsBloc,
      buildWhen: (previous, current) => current is! FriendRequestState,
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
                  bool isRequestSent =
                      _suggestedFriendsBloc.sentRequestIds.contains(data.id);

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4),
                    child: Card(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.07,
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
                              buildWhen: (previous, current) {
                                return current is FriendRequestStatusState ||
                                    current is SuggestedFriendsSuccessState;
                              },
                              builder: (context, state) {
                                return GestureDetector(
                                  onTap: () {
                                    if (!isRequestSent) {
                                      _suggestedFriendsBloc.add(
                                          SendFriendRequestEvent(
                                              userId: data.id));
                                    } else {
                                      _suggestedFriendsBloc.add(
                                          DeleteFriendRequestEvent(
                                              userId: data.id));
                                    }
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    decoration: BoxDecoration(
                                      color: isRequestSent ||
                                              data.friendsRequests.contains(id)
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onBackground
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        isRequestSent ||
                                                data.friendsRequests
                                                    .contains(id)
                                            ? 'Requested'
                                            : 'Add Friend',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: isRequestSent ||
                                                  data.friendsRequests
                                                      .contains(id)
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .background
                                              : const Color.fromARGB(
                                                  255, 29, 29, 29),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )),
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
    );
  }
}
