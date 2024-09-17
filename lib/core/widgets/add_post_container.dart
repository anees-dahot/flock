import 'package:flock/features/add%20posts/screens/add_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPostContainer extends StatelessWidget {
  const AddPostContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(AddPost.routeName),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.pencil,
                        color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 12),
                    Text(
                      "What's on your mind?",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPost.routeName);
              },
              icon: Icon(
                CupertinoIcons.photo,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
