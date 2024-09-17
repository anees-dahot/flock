import 'package:cached_network_image/cached_network_image.dart';
import 'package:flock/core/widgets/add_post_container.dart';
import 'package:flock/features/profile/bloc/profile_bloc.dart';
import 'package:flock/features/profile/repository/profile_repository.dart';
import 'package:flock/features/profile/widgets/action_buttons_widget.dart';
import 'package:flock/features/profile/widgets/friends_section.dart';
import 'package:flock/features/profile/widgets/profile_header_widget.dart';
import 'package:flock/features/profile/widgets/user_name_widget.dart';
import 'package:flock/models/user.dart';
import 'package:flock/utils/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    super.initState(); // Move this to the top
    if (widget.user != null) {
      // Check if user is not null
      _profileBloc = ProfileBloc(profileRepository: ProfileRepository());
      _profileBloc.add(GetFriendRequestsEvent(userId: widget.user!.id!));
      getId();
    }
  }

  void getId() async {
    await Storage().getUserData().then((value) {
      if (widget.user != null) {
        // Check if user is not null
        setState(() {
          id = value!.id;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user == null) {
      // Handle null user case
      return const Center(child: CircularProgressIndicator());
    }
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
              //* Profile Header
              ProfileHeader(size: size, widget: widget),
              SizedBox(height: size.height * 0.1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* UserName Widget
                    UserNameWIdget(widget: widget, size: size),
                    //*-------
                    Text(
                      widget.user!.bio!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    //* Action Buttons
                    ActionButtons(size: size, widget: widget, id: id),
                    //*-------
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
                    //* Friends Section
                    FriendsSection(profileBloc: _profileBloc, size: size),
                    //*-------
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
                    const AddPostContainer(),
                    // SizedBox(height: size.height * 0.02),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
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
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Text(
                                  'This is the post content ' * 8,
                                  style: const TextStyle(fontSize: 16),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(CupertinoIcons.heart,
                                          color: Colors.red),
                                      onPressed: () {},
                                    ),
                                    const SizedBox(width: 4),
                                    const Text('1.2k',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 16),
                                    IconButton(
                                      icon: const Icon(CupertinoIcons.chat_bubble,
                                          color: Colors.blue),
                                      onPressed: () {},
                                    ),
                                    const SizedBox(width: 4),
                                    const Text('84',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
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
