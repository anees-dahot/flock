import 'package:flock/features/create%20account/screens/create_account.dart';
import 'package:flock/features/create%20account/screens/pick_profile_image.dart';
import 'package:flock/features/create%20account/screens/suggested_friends.dart';
import 'package:flock/features/home/screens/hom_screen.dart';
import 'package:flock/features/login/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../features/create account/screens/pick_profile_cover.dart';
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
    case SuggestedFriends.routeName:
      return MaterialPageRoute(builder: (_) => SuggestedFriends());
    case CreateAccount.routeName:
      final argument = routeSettings.arguments as List;

      return MaterialPageRoute(
          builder: (_) => CreateAccount(
                profileImage: argument[0],
                profileCover: argument[1], // Pass the new argument
              ));
    case PickProfileCover.routeName:
      final String image = routeSettings.arguments.toString();
      return MaterialPageRoute(
          builder: (_) => PickProfileCover(
                profileImage: image,
              ));
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
