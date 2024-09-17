import 'package:cached_network_image/cached_network_image.dart';
import 'package:flock/features/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.size,
    required this.widget,
  });

  final Size size;
  final ProfileScreen widget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomLeft,
      children: [
        SizedBox(
          width: size.width,
          height: size.height * 0.3,
          child: CachedNetworkImage(
            imageUrl: widget.user!.profileCover!,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                const Icon(Icons.error),
          ),
        ),
        Container(
          width: size.width,
          height: size.height * 0.3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.transparent,
              ],
            ),
          ),
        ),
        Positioned(
          bottom: -60,
          left: 20,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(75),
              child: CachedNetworkImage(
                imageUrl: widget.user!.profileImage!,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
              ),
            ),
          ),
        ),
      ],
    );
  }
}