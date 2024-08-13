import 'package:flock/features/create%20account/blocs/sugges%20friends%20bloc/suggested_friends_bloc.dart';
import 'package:flock/features/create%20account/repository/suggested_friends_repositoy.dart';
import 'package:flock/features/home/screens/hom_screen.dart';
import 'package:flock/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/request_counts.dart';
import '../widgets/suggested_friends_list.dart';

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

    assignId();
    super.initState();
  }

  void assignId() async {
    await Storage().getUserData().then((value) {
      id = value!.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => _suggestedFriendsBloc,
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text(
                'Add Friends',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              backgroundColor: Theme.of(context).colorScheme.background,
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomeScreen.routeName, (route) => false);
                    },
                    child: Text('Skip',
                        style: Theme.of(context).textTheme.bodyLarge))
              ],
            ),
            body: Column(
              children: [
                SizedBox(height: height * 0.05),
                Text(
                  'Suggested Friends',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 8),
                RequestsCount(suggestedFriendsBloc: _suggestedFriendsBloc),
                SizedBox(height: height * 0.05),
                SuggestedFriendsList(
                    suggestedFriendsBloc: _suggestedFriendsBloc, id: id)
              ],
            ),
          ),
          BlocBuilder<SuggestedFriendsBloc, SuggestedFriendsState>(
            bloc: _suggestedFriendsBloc,
            builder: (context, state) {
              return _suggestedFriendsBloc.currentRequestCount >= 5
                  ? Positioned(
                      bottom: 16,
                      right: 16,
                      child: FloatingActionButton(
                        onPressed: () {
                          _suggestedFriendsBloc.prefs
                              .remove('sentRequestIds')
                              .then((value) {
                            Navigator.pushNamedAndRemoveUntil(context,
                                HomeScreen.routeName, (route) => false);
                          });
                        },
                        child: const Icon(Icons.arrow_forward),
                      ),
                    )
                  : const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
