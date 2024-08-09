import 'package:flock/features/create%20account/screens/pick_profile_image.dart';
import 'package:flock/features/home/screens/hom_screen.dart';
import 'package:flock/features/login/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../features/register account/screens/register_account_screen.dart';

Route generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => HomeScreen());
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => LoginScreen());
    case RegisterScreen.routeName:
      return MaterialPageRoute(builder: (_) => RegisterScreen());
    case PickProfileImage.routeName:
      return MaterialPageRoute(builder: (_) => PickProfileImage());
    default:
      return MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: Text('No screen found.'),
            ),
          );
        },
      );
  }
}
