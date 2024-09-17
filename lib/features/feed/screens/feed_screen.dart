import 'package:cached_network_image/cached_network_image.dart';
import 'package:flock/core/widgets/add_post_container.dart';
import 'package:flock/features/feed/bloc/feed_bloc.dart';
import 'package:flock/features/feed/repository/feed_repository.dart';
import 'package:flock/features/feed/widgets/post_images_widget.dart';
import 'package:flock/features/login/screens/login_screen.dart';
import 'package:flock/features/profile/screens/profile_screen.dart';
import 'package:flock/utils/flush_message.dart';
import 'package:flock/utils/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FeedBloc _feedBloc;
  @override
  void initState() {
    _feedBloc = FeedBloc(feedRepository: FeedRepository());
    _feedBloc.add(GetPostsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => _feedBloc,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Flock',
              style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
                icon: const Icon(CupertinoIcons.search),
                onPressed: () async {
                  await Storage().deleteData('token').then((value) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        LoginScreen.routeName, (route) => false);
                  }).onError((error, stackTrace) {
                    NotificationHelper.showErrorNotification(
                        context, error.toString());
                  });
                }),
            IconButton(icon: const Icon(CupertinoIcons.bell), onPressed: () {}),
          ],
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: Column(
          children: [
            const AddPostContainer(),
            BlocBuilder<FeedBloc, FeedState>(
              bloc: _feedBloc,
              builder: (context, state) {
                if (state is GetPostsLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetPostsErrorgState) {
                  return Center(child: Text(state.error));
                } else if (state is GetPostsSuccessState) {
                  final posts = state.posts;
                  return Expanded(
                      child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      final data = posts[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                    data.userPosted!.profileImage!),
                                radius: 20,
                              ),
                              title: Text(
                                data.userPosted!.fullName!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                'This is the post content ' * 8,
                                style: TextStyle(fontSize: 16),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(CupertinoIcons.heart,
                                        color: Colors.red),
                                    onPressed: () {},
                                  ),
                                  SizedBox(width: 4),
                                  Text('1.2k',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(width: 16),
                                  IconButton(
                                    icon: Icon(CupertinoIcons.chat_bubble,
                                        color: Colors.blue),
                                    onPressed: () {},
                                  ),
                                  SizedBox(width: 4),
                                  Text('84',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ));
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
