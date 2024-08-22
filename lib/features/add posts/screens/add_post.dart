import 'package:cached_network_image/cached_network_image.dart';
import 'package:flock/models/user.dart';
import 'package:flock/utils/storage.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() async {
    user = await Storage().getUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            child: const Text('Publish',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
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
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  items: ['Public', 'Private'].map((String value) {
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
                                  icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
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
              if (_isImageSelected)
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.image,
                      size: 50,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageButton() {
    return InkWell(
      onTap: () {
        setState(() {
          _isImageSelected = !_isImageSelected;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _isImageSelected ? Colors.blue.shade100 : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.image,
              size: 18,
              color: _isImageSelected ? Colors.blue : Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Text(
              'Photo',
              style: TextStyle(
                color: _isImageSelected ? Colors.blue : Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}