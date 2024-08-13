import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../search/screens/search_screen.dart';

class TabScreen extends StatefulWidget {
  static const String routeName = 'tab-screen';

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'FLOCK',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(SearchScreen.routeName, arguments: true);
              },
              icon: const Icon(CupertinoIcons.search),
            ),
            IconButton(
              onPressed: () {
                print('bubble cliked');
              },
              icon: const Icon(CupertinoIcons.chat_bubble_text),
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
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
                icon: Icon(CupertinoIcons.home),
              ),
              
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            Center(child: Text('Content for Tab 1')),
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
