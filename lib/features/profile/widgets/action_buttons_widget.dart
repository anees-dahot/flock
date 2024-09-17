import 'package:flock/features/profile/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
    required this.size,
    required this.widget,
    required this.id,
  });

  final Size size;
  final ProfileScreen widget;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            width: size.width * 0.42,
            height: size.height * 0.055,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.user!.id == id
                    ? const Icon(CupertinoIcons.pencil)
                    : widget.user!.friends!.contains(id)
                        ? const Icon(
                            Icons.group,
                          )
                        : const Icon(
                            Icons.person_add_alt,
                          ),
                const SizedBox(width: 8),
                Text(
                    widget.user!.id == id
                        ? 'Add to story'
                        : widget.user!.friends!.contains(id)
                            ? 'Friends'
                            : 'Send request',
                    style:
                        Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: size.width * 0.4,
            height: size.height * 0.055,
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.user!.id == id
                    ? const Icon(CupertinoIcons
                        .person_crop_circle_badge_exclam)
                    : const Icon(Icons.message,
                        color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  widget.user!.id == id
                      ? 'Edit profile'
                      : 'Message',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}




