import 'package:flock/features/add%20posts/screens/add_post.dart';
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
            Padding(
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
            ),
            BlocBuilder<FeedBloc, FeedState>(
              bloc: _feedBloc,
              builder: (context, state) {
                if (state is GetPostsLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is GetPostsErrorgState) {
                  return Center(child: Text(state.error));
                } else if (state is GetPostsSuccessState) {
                  final posts = state.posts;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final data = posts[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: GestureDetector(
                                  onTap: () => Navigator.of(context).pushNamed(ProfileScreen.routeName, arguments: data.userPosted),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        data.userPosted!.profileImage ?? ''),
                                  ),
                                ),
                                title: Text(data.userPosted!.fullName!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(data.postedAt!.toString()),
                                trailing: IconButton(
                                  icon: const Icon(CupertinoIcons.ellipsis),
                                  onPressed: () {
                                    // Add your onPressed logic here
                                  },
                                ),
                              ),
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(15)),
                                child: ImageGridWidget(
                                    images: data.postImages ?? []),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(CupertinoIcons.heart,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground),
                                        const SizedBox(width: 4),
                                        Text('1.2k',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground)),
                                        const SizedBox(width: 16),
                                        Icon(CupertinoIcons.chat_bubble,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground),
                                        const SizedBox(width: 4),
                                        Text('84',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground)),
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
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
