import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flock/core/theme/theme_cubit.dart';
import 'package:flock/features/login/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello World',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 20),
            Divider(color: Theme.of(context).dividerColor, height: 12),
            _ThemeToggleButton(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginScreen()));
              },
              child: Text('Go to Login'),
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
          child: Text('Light Theme'),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => context.read<ThemeCubit>().setTheme(ThemeMode.dark),
          child: Text('Dark Theme'),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          child: Text('Toggle Theme'),
        ),
      ],
    );
  }
}
