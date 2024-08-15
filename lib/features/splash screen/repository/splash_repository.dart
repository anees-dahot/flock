import 'package:flock/features/login/screens/login_screen.dart';
import 'package:flock/utils/flush_message.dart';
import 'package:flock/utils/storage.dart';
import 'package:flutter/material.dart';

import '../../navigation bar/screens/navigation_bar.dart';

class SplashRepository {
  void redirectUser(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    Storage().getData('token').then((value) {
      if (value == '') {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            NavigationBarScreen.routeName, (route) => false);
      }
    }).onError((error, stackTrace) {
      NotificationHelper.showErrorNotification(context, error.toString());
    });
  }
}
