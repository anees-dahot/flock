import 'package:flock/features/create%20account/repository/suggested_friends_repositoy.dart';

import 'package:flutter/material.dart';

import '../widgets/search_bar.dart';

class TabScreen extends StatefulWidget {
  static const String routeName = 'tab-screen';

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  SuggestedFriendsRepository suggestedFriendsRepository =
      SuggestedFriendsRepository();

  @override
  void initState() {
    suggestedFriendsRepository.getSuggestedFriends();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [SearchBarWidget(size: size)],
            ),
          ),
        ),
      ),
    );
  }
}
