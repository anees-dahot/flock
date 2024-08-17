import 'package:cached_network_image/cached_network_image.dart';
import 'package:flock/models/user.dart';
import 'package:flock/utils/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'profile-screen';
  const ProfileScreen({super.key, this.user});
  final UserModel? user;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? id;

  @override
  void initState() {
    super.initState();
    getId();
  }

  void getId() async {
    await Storage().getUserData().then((value) {
      setState(() {
        id = value!.id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomLeft,
              children: [
                SizedBox(
                  width: size.width,
                  height: size.height * 0.3,
                  child: CachedNetworkImage(
                    imageUrl: widget.user!.profileCover,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 10,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
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
                        imageUrl: widget.user!.profileImage,
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
            ),
            SizedBox(height: size.height * 0.1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.user!.fullName,
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
                  ),
                  Text(
                    widget.user!.bio,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: size.width * 0.4,
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
                                  : widget.user!.friends.contains(id)
                                      ? const Icon(Icons.group,
                                          color: Colors.white)
                                      : const Icon(Icons.person_add_alt,
                                          color: Colors.white),
                              const SizedBox(width: 8),
                              Text(
                                widget.user!.id == id
                                    ? 'Add to story'
                                    : widget.user!.friends.contains(id)
                                        ? 'Friends'
                                        : 'Send request',
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
                      const SizedBox(width: 30),
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
