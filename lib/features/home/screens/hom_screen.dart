import 'package:flock/features/create%20account/repository/suggested_friends_repositoy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flock/core/theme/theme_cubit.dart';
import 'package:flock/features/login/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SuggestedFriendsRepository suggestedFriendsRepository =
      SuggestedFriendsRepository();
  @override
  void initState() {
    suggestedFriendsRepository.getSuggestedFriends();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello World',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 20),
            Divider(color: Theme.of(context).dividerColor, height: 12),
            _ThemeToggleButton(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
              child: const Text('Go to Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => context.read<ThemeCubit>().setTheme(ThemeMode.light),
          child: const Text('Light Theme'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => context.read<ThemeCubit>().setTheme(ThemeMode.dark),
          child: const Text('Dark Theme'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          child: const Text('Toggle Theme'),
        ),
      ],
    );
  }
}
