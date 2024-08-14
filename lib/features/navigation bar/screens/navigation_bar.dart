import 'package:flock/features/feed/screens/feed_screen.dart';
import 'package:flock/features/friend%20requests/screens/friend_requests_screen.dart';
import 'package:flutter/material.dart';

class NavigationBarScreen extends StatefulWidget {
  static const String routeName = 'navigation-bar';

  const NavigationBarScreen({super.key});
  @override
  _NavigationBarScreenState createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _selectedIndex = 0;
  final List<Widget> pages = [
    HomePage(),
    FriendRequests(),
    HomePage(),
  ];

  void updatePage(int page) {
    setState(() {
      _selectedIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 65,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(32.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(0, Icons.home_rounded, Icons.home_outlined),
        _buildNavItem(1, Icons.groups_rounded, Icons.groups_outlined),
        _buildNavItem(2, Icons.person_add_alt_1_rounded, Icons.person_add_alt_outlined),
        _buildNavItem(3, Icons.person_rounded, Icons.person_outlined),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      int index, IconData selectedIcon, IconData unselectedIcon) {
    return InkWell(
      onTap: () => updatePage(index),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.15,
        height: 50,
        decoration: BoxDecoration(
          color: _selectedIndex == index
              ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Icon(
          _selectedIndex == index ? selectedIcon : unselectedIcon,
          color: _selectedIndex == index
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onPrimaryContainer,
          size: 28,
        ),
      ),
    );
  }
}
