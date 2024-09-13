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
    _profileBloc.add(GetFriendRequestsEvent(userId: widget.user!.id!));
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
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
                    ),
                    Text(
                      widget.user!.bio!,
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
                                    : widget.user!.friends!.contains(id!)
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
                                        : widget.user!.friends!.contains(id!)
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
                    ),
                    const SizedBox(
                      height: 20,
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(state.error),
                            ),
                          );
                        } else if (state is GetFriendRequestsSuccessState) {
                          return SizedBox(
                              width: size.width * 0.9,
                              height: size.height * 0.39,
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
                                              crossAxisSpacing: 20),
                                      itemCount:
                                          state.friendRequests.length == 6
                                              ? 6
                                              : state.friendRequests.length < 6
                                                  ? state.friendRequests.length
                                                  : 6,
                                      itemBuilder: (context, index) {
                                        final data =
                                            state.friendRequests[index];
                                        return GestureDetector(
                                          onTap: () => Navigator.of(context)
                                              .pushNamed(
                                                  ProfileScreen.routeName,
                                                  arguments: data),
                                          child: Column(
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
                                                    imageUrl:
                                                        data.profileImage!,
                                                    fit: BoxFit.cover,
                                                    placeholder: (context,
                                                            url) =>
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
                                                  data.fullName!,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  // SizedBox(height: size.height * 0.01),
                                  Container(
                                    width: size.width * 0.9,
                                    height: size.height * 0.055,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Center(
                                      child: Text(
                                        'See all friends',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                  )
                                ],
                              ));
                        } else {
                          return Container(
                            width: size.width * 0.9,
                            height: size.height * 0.3,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
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
                    Text(
                      'Posts',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: 50,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.pencil,
                                    color:
                                        Theme.of(context).colorScheme.primary),
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
                        const SizedBox(width: 12),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              CupertinoIcons.photo,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: size.height * 0.02),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      widget.user!.profileImage!),
                                  radius: 20,
                                ),
                                title: Text(
                                  widget.user!.fullName!,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                trailing: IconButton(
                                  icon: Icon(CupertinoIcons.ellipsis),
                                  onPressed: () {},
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Text(
                                  'Its Post content. ' * 10,
                                  style: TextStyle(fontSize: 16),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(CupertinoIcons.heart,
                                            color: Colors.red),
                                        SizedBox(width: 4),
                                        Text('1.2k',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(width: 16),
                                        Icon(CupertinoIcons.chat_bubble,
                                            color: Colors.blue),
                                        SizedBox(width: 4),
                                        Text('84',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Icon(CupertinoIcons.share,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
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
