import 'package:cached_network_image/cached_network_image.dart';
import 'package:flock/features/profile/bloc/profile_bloc.dart';
import 'package:flock/features/profile/repository/profile_repository.dart';
import 'package:flock/models/user.dart';
import 'package:flock/utils/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'profile-screen';
  const ProfileScreen({super.key, this.user});
  final UserModel? user;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileBloc _profileBloc;
  String? id;

  @override
  void initState() {
    _profileBloc = ProfileBloc(profileRepository: ProfileRepository());
    _profileBloc.add(GetFriendRequestsEvent());
    getId();
    super.initState();
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
    return BlocProvider(
      create: (context) => _profileBloc,
      child: Scaffold(
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Divider(
                      thickness: 1,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Friends',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<ProfileBloc, ProfileState>(
                      bloc: _profileBloc,
                      builder: (context, state) {
                        if (state is GetFriendRequestsLoadingState) {
                          return Container(
                            width: size.width * 0.9,
                            height: size.height * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (state is GetFriendRequestsFailureState) {
                          return Container(
                            width: size.width * 0.9,
                            height: size.height * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(state.error),
                            ),
                          );
                        } else if (state is GetFriendRequestsSuccessState) {
                          return Container(
                              padding: const EdgeInsets.all(10),
                              width: size.width * 0.9,
                              height: size.height * 0.39,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: GridView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14),
                                      shrinkWrap: true, // Prevent scrolling
                                      physics:
                                          const NeverScrollableScrollPhysics(), // Prevent scrolling
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              childAspectRatio: 0.68,
                                              crossAxisSpacing: 14),
                                      itemCount:
                                          state.friendRequests.length == 6
                                              ? 6
                                              : state.friendRequests.length < 6
                                                  ? state.friendRequests.length
                                                  : 6,
                                      itemBuilder: (context, index) {
                                        final data =
                                            state.friendRequests[index];
                                        return Column(
                                          children: [
                                            Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: CachedNetworkImage(
                                                  imageUrl: data.profileImage,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Container(
                                                    color: Colors.grey[300],
                                                    child: Icon(Icons.person,
                                                        size: 50,
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Flexible(
                                              child: Text(
                                                data.fullName,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  // SizedBox(height: size.height * 0.01),
                                  Container(
                                    width: size.width * 0.8,
                                    height: size.height * 0.055,
                                   decoration: 
                                   BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(12)
                                   ),
                                   child: Center(child: Text('See more', style: Theme.of(context).textTheme.bodyLarge,),),
                                  )
                                ],
                              ));
                        } else {
                          return Container(
                            width: size.width * 0.9,
                            height: size.height * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: Text('Nothing'),
                            ),
                          );
                        }
                      },
                    ),
                     const SizedBox(
                      height: 20,
                    ),
                    Divider(
                      thickness: 1,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.14)
            ],
          ),
        ),
      ),
    );
  }
}
