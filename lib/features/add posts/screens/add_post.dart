import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flock/features/add%20posts/bloc/add_post_bloc.dart';
import 'package:flock/models/user.dart';
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
  bool _isImageSelected = false;
  String? _visibilityValue = 'Public';
  UserModel? user;
  late AddPostBloc _addPostBloc;

  @override
  void initState() {
    getUser();
    _addPostBloc = AddPostBloc();
    super.initState();
  }

  void getUser() async {
    user = await Storage().getUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _addPostBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Post',
              style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            TextButton(
              child: const Text('Publish',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold)),
              onPressed: () {
                // Call the function to publish the post
              },
            ),
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
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    items: ['Public', 'Private']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    value: _visibilityValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _visibilityValue = value;
                                      });
                                    },
                                    icon:  Icon(Icons.arrow_drop_down,
                                    color: Theme.of(context).colorScheme.onBackground,),
                                    isDense: true,
                                  ),
                                ),
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
  builder: (context, state) {
    if (state is PickPostImagesSuccessState && state.images.isNotEmpty) {
      return Container(
        height: 400,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: _buildImageGrid(state.images),
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
      children: imagePaths.map((path) => Expanded(
        child: Image.file(File(path), fit: BoxFit.cover)
      )).toList(),
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
              Expanded(child: Image.file(File(imagePaths[1]), fit: BoxFit.cover)),
              const SizedBox(height: 2),
              Expanded(child: Image.file(File(imagePaths[2]), fit: BoxFit.cover)),
            ],
          ),
        ),
      ],
    );
  } else {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: imagePaths.asMap().entries.map((entry) {
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
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Image.file(File(path), fit: BoxFit.cover);
      }).toList().sublist(0, imageCount > 4 ? 4 : imageCount),
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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

  const ImageGalleryPage({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
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