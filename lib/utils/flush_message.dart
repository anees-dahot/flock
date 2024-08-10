import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class NotificationHelper {
  static void showNotification(
    BuildContext context, {
    required String message,
    required Color color,
    required IconData icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    Flushbar(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      message: message,
      icon: Icon(
        icon,
        size: 28.0,
        color: color,
      ),
      duration: duration,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: Colors.black.withOpacity(0.9),
      borderRadius: BorderRadius.circular(15),
      boxShadows: const [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      // leftBarIndicatorColor: color,
    ).show(context);
  }

  static void showSuccessNotification(BuildContext context, String message) {
    showNotification(
      context,
      message: message,
      color: Colors.green,
      icon: Icons.check_circle,
    );
  }

  static void showErrorNotification(BuildContext context, String message) {
    showNotification(
      context,
      message: message,
      color: Colors.red,
      icon: Icons.error,
    );
  }
}