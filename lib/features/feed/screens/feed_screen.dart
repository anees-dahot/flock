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
                    physics: const ClampingScrollPhysics(),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final data = posts[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ListTile for user profile and post date
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                    data.userPosted!.profileImage!),
                                radius: 20,
                              ),
                              title: Text(
                                data.userPosted!.fullName!,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                               subtitle: Text(
                                '${data.postedAt!.day}-${data.postedAt!.month}-${data.postedAt!.year} ${data.postedAt!.hour}:${data.postedAt!.minute} ${data.postedAt!.hour > 12 ? "PM" : "AM"}',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),

                            // Post text content
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                data.postText.toString(),
                                style: const TextStyle(fontSize: 16),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            // Handling images dynamically based on count
                            if (data.postImages != null && data.postImages!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: _buildImageLayout(data.postImages!),
                              ),

                            // Like and comment row
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon:  Icon(CupertinoIcons.heart,
                                        color: Theme.of(context).colorScheme.secondaryContainer),
                                    onPressed: () {},
                                  ),
                                  const SizedBox(width: 4),
                                  const Text('1.2k',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 16),
                                  IconButton(
                                    icon:  Icon(CupertinoIcons.chat_bubble,
                                        color: Theme.of(context).colorScheme.secondaryContainer),
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
// Helper method to handle different image layouts
Widget _buildImageLayout(List<String> images) {
  if (images.length == 1) {
    // Display a single image
    return CachedNetworkImage(
      imageUrl: images[0],
      width: double.infinity,
      height: 200,
      fit: BoxFit.cover,
    );
  } else if (images.length == 2) {
    // Display two images in a row
    return Row(
      children: images.map((image) {
        return Expanded(
          child: CachedNetworkImage(
            imageUrl: image,
            height: 150,
            fit: BoxFit.cover,
            // margin: EdgeInsets.only(right: images.last != image ? 8 : 0),
          ),
        );
      }).toList(),
    );
  } else if (images.length == 3) {
    // Display three images with the first one spanning across and the rest two in a row
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: images[0],
          width: double.infinity,
          height: 150,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 8),
        Row(
          children: images.sublist(1).map((image) {
            return Expanded(
              child: CachedNetworkImage(
                imageUrl: image,
                height: 100,
                fit: BoxFit.cover,
                // margin: EdgeInsets.only(right: images.last != image ? 8 : 0),
              ),
            );
          }).toList(),
        ),
      ],
    );
  } else if (images.length == 4) {
    // Display four images in a grid
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: images.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return CachedNetworkImage(
          imageUrl: images[index],
          fit: BoxFit.cover,
        );
      },
    );
  } else {
    // Display more than four images with a grid of four images and a "see more" label
    return Column(
      children: [
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 4, // Show only 4 images in the grid
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return CachedNetworkImage(
              imageUrl: images[index],
              fit: BoxFit.cover,
            );
          },
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'View all ${images.length} photos',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
