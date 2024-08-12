import 'package:cached_network_image/cached_network_image.dart';
import 'package:flock/features/create%20account/blocs/sugges%20friends%20bloc/suggested_friends_bloc.dart';
import 'package:flock/features/create%20account/repository/suggested_friends_repositoy.dart';
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
  @override
  void initState() {
    _suggestedFriendsBloc = SuggestedFriendsBloc(
        suggestedFriendsRepository: SuggestedFriendsRepository());
    _suggestedFriendsBloc.add(GetSuggestedFriendsEvent());
    super.initState();
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
              listener: (context, state) {},
              builder: (context, state) {
                if (state is SuggestedFriendsLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is SuggestedFriendsFailureState) {
                  return Center(child: Text(state.error));
                } else if (state is SuggestedFriendsSuccessState) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.suggestedFriends.length,
                      itemBuilder: (context, index) {
                        var data = state.suggestedFriends[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4),
                          child: Card(
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              width: width * 0.9,
                              height: height * 0.07,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14)),
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
                                trailing: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: width * 0.3,
                                    height: height * 0.07,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Center(
                                        child: Text(
                                      'Add Friend',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
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
