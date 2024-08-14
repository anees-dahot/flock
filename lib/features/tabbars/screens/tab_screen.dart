import 'package:flock/utils/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../feed/screens/feed_screen.dart';
import '../../search/screens/search_screen.dart';

class TabScreen extends StatefulWidget {
  static const String routeName = 'tab-screen';

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? profileImage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    getUser();
    Future.delayed(const Duration(milliseconds: 10), () {
      print(profileImage);
    });
  }

  void getUser() async {
    await Storage().getUserData().then((value) {
      profileImage = value!.profileImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'FLOCK',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(SearchScreen.routeName, arguments: true);
              },
              icon: const Icon(CupertinoIcons.search),
              tooltip: 'Search',
            ),
            IconButton(
              onPressed: () {
                print('bubble clicked');
              },
              icon: const Icon(CupertinoIcons.chat_bubble_text),
              tooltip: 'Chat',
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: const [
              Tab(
                icon: Icon(CupertinoIcons.home),
              ),
              Tab(
                icon: Icon(CupertinoIcons.group),
              ),
              Tab(
                icon: Icon(CupertinoIcons.profile_circled),
              ),
              Tab(
                icon: Icon(CupertinoIcons.settings),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
          FeedScreen(),
            Center(child: Text('Content for Tab 2')),
            Center(child: Text('Content for Tab 3')),
            Center(child: Text('Content for Tab 4')),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
