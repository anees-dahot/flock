import 'package:flock/features/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class UserNameWIdget extends StatelessWidget {
  const UserNameWIdget({
    super.key,
    required this.widget,
    required this.size,
  });

  final ProfileScreen widget;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.user!.fullName!,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        SizedBox(
          width: size.width * 0.02,
        ),
        Text(
        '( ${widget.user!.userName} )',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}