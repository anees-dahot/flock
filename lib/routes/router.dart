import 'package:flock/features/create%20account/screens/create_account.dart';
import 'package:flock/features/create%20account/screens/pick_profile_image.dart';
import 'package:flock/features/create%20account/screens/suggested_friends.dart';
import 'package:flock/features/login/screens/login_screen.dart';
import 'package:flock/features/profile/screens/profile_screen.dart';
import 'package:flock/features/search/screens/search_screen.dart';
import 'package:flock/models/user.dart';
import 'package:flutter/material.dart';

import '../features/create account/screens/pick_profile_cover.dart';
import '../features/register account/screens/register_account_screen.dart';
import '../features/navigation bar/screens/navigation_bar.dart';

Route generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case NavigationBarScreen.routeName:
      return MaterialPageRoute(builder: (_) => const NavigationBarScreen());
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case RegisterScreen.routeName:
      return MaterialPageRoute(builder: (_) => const RegisterScreen());
    case ProfileScreen.routeName:
      final user = routeSettings.arguments as UserModel;
      return MaterialPageRoute(builder: (_) => ProfileScreen(user: user,));
    case PickProfileImage.routeName:
      return MaterialPageRoute(builder: (_) => const PickProfileImage());
    case NavigationBarScreen.routeName:
      return MaterialPageRoute(builder: (_) => const NavigationBarScreen());
    case SuggestedFriends.routeName:
      return MaterialPageRoute(builder: (_) => const SuggestedFriends());
    case SearchScreen.routeName:
      final bool autoFocus = routeSettings.arguments as bool;
      return MaterialPageRoute(
          builder: (_) => SearchScreen(autoFocus: autoFocus));
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
          return const Scaffold(
            body: Center(
              child: Text('No screen found.'),
            ),
          );
        },
      );
  }
}
