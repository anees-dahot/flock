import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flock/features/add%20posts/bloc/add_post_bloc.dart';
import 'package:flock/features/add%20posts/repository/add_post_repository.dart';
import 'package:flock/models/user.dart';
import 'package:flock/utils/flush_message.dart';
import 'package:flock/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController _textController = TextEditingController();
  String? visibilityValue = 'Public';
  List<String> images = [];
  UserModel? user;
  late AddPostBloc _addPostBloc;

  @override
  void initState() {
    getUser();
    initialization();
    _addPostBloc = AddPostBloc(addPostRepository: AddPostRepository());
    super.initState();
  }

  @override
  void dispose() {
    _addPostBloc.close();
    // TODO: implement dispose
    super.dispose();
  }

  void getUser() async {
    user = await Storage().getUserData();
    setState(() {});
  }

  void initialization() async {
    final List<String>? images =
        await Storage().deleteList('images') as List<String>?;
    if (images != null) {
      // Check if images is not null
      print(images.length);
    } else {
      print('No images found'); // Handle the null case
    }
    await Storage().saveDate('visibilityType', 'Public');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => _addPostBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Post',
              style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            BlocConsumer<AddPostBloc, AddPostState>(
                bloc: _addPostBloc,
                listenWhen: (previous, current) =>
                    current is AddPostSuccess || current is AddPostError,
                listener: (context, state) {
                  if (state is AddPostError) {
                    NotificationHelper.showErrorNotification(
                        context, state.error);
                    _addPostBloc.add(ResetAddPostState());
                  } else if (state is AddPostSuccess) {
                    NotificationHelper.showSuccessNotification(
                        context, state.message);
                    _addPostBloc.add(ResetAddPostState());
                  }
                },
                builder: (context, state) {
                  if (state is AddPostLoading) {
                    return Container(
                      width: size.width * 0.28,
                      height: size.height * 0.05,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        _addPostBloc.add(AddPostFunction(
                          postText: _textController.text,
                          postVideos: const [],
                        ));
                      },
                      child: Container(
                        width: size.width * 0.28,
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Publish',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    );
                  }
                })
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: user?.profileImage != null
                          ? CachedNetworkImageProvider(user!.profileImage)
                          : null,
                      radius: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.fullName ?? 'User Name',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              BlocBuilder<AddPostBloc, AddPostState>(
                                bloc: _addPostBloc,
                                builder: (context, state) {
                                  String currentVisibility = visibilityValue!;
                                  if (state.visibilityType != '') {
                                    currentVisibility = state.visibilityType;
                                  }
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        items: ['Public', 'Private']
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  value == 'Public'
                                                      ? Icons.public
                                                      : Icons.lock,
                                                  size: 18,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  value,
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                        value: currentVisibility,
                                        onChanged: (value) {
                                          _addPostBloc.add(
                                            ChoosePostVisibilityEvent(
                                                visibilityType: value!),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                        isDense: true,
                                        dropdownColor: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                        borderRadius: BorderRadius.circular(16),
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                              _buildImageButton(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _textController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'What\'s on your mind?',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<AddPostBloc, AddPostState>(
                  bloc: _addPostBloc,
                  buildWhen: (previous, current) =>
                      current is AddPostImagesUpdated,
                  builder: (context, state) {
                    if (state.images.isNotEmpty) {
                      return SizedBox(
                        height: 400,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: _buildImageGrid(state.images),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageGrid(List<String> imagePaths) {
    int imageCount = imagePaths.length;

    if (imageCount == 1) {
      return Image.file(File(imagePaths[0]), fit: BoxFit.cover);
    } else if (imageCount == 2) {
      return Row(
        children: imagePaths
            .map((path) =>
                Expanded(child: Image.file(File(path), fit: BoxFit.cover)))
            .toList(),
      );
    } else if (imageCount == 3) {
      return Row(
        children: [
          Expanded(
            flex: 2,
            child: Image.file(File(imagePaths[0]), fit: BoxFit.cover),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: Column(
              children: [
                Expanded(
                    child: Image.file(File(imagePaths[1]), fit: BoxFit.cover)),
                const SizedBox(height: 2),
                Expanded(
                    child: Image.file(File(imagePaths[2]), fit: BoxFit.cover)),
              ],
            ),
          ),
        ],
      );
    } else {
      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        children: imagePaths
            .asMap()
            .entries
            .map((entry) {
              int idx = entry.key;
              String path = entry.value;
              if (idx == 3 && imageCount > 4) {
                return GestureDetector(
                  onTap: () => _openImageGallery(imagePaths),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(File(path), fit: BoxFit.cover),
                      Container(
                        color: Colors.black54,
                        child: Center(
                          child: Text(
                            '+${imageCount - 4}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Image.file(File(path), fit: BoxFit.cover);
            })
            .toList()
            .sublist(0, imageCount > 4 ? 4 : imageCount),
      );
    }
  }

  void _openImageGallery(List<String> imagePaths) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ImageGalleryPage(images: imagePaths),
    ));
  }

  Widget _buildImageButton() {
    return InkWell(
      onTap: () {
        _addPostBloc.add(PickPostImagesEvent());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.image,
              size: 18,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            const SizedBox(width: 4),
            Text(
              'Photo',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageGalleryPage extends StatelessWidget {
  final List<String> images;

  const ImageGalleryPage({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return InteractiveViewer(
            child: Image.file(
              File(images[index]),
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}
