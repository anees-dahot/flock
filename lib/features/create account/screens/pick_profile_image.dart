import 'dart:io';

import 'package:flock/core/widgets/custom_button.dart';
import 'package:flock/features/create%20account/blocs/image%20picker%20bloc/image_picker_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickProfileImage extends StatefulWidget {
  static const String routeName = 'pick-image-screen';
  const PickProfileImage({super.key});

  @override
  State<PickProfileImage> createState() => _PickProfileImageState();
}

class _PickProfileImageState extends State<PickProfileImage> {
  late ImagePickerBloc _imagePickerBloc;
  @override
  void initState() {
    _imagePickerBloc = ImagePickerBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => _imagePickerBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Pick Profile Image',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Pick Image:",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: height * 0.02),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width * 0.12,
                    height: height * 0.07,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onBackground,
                        borderRadius: BorderRadius.circular(14)),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.camera_fill,
                          size: 30,
                          color: Theme.of(context).colorScheme.background,
                        )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: width * 0.12,
                    height: height * 0.07,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onBackground,
                        borderRadius: BorderRadius.circular(14)),
                    child: IconButton(
                        onPressed: () {
                          _imagePickerBloc.add(PickImageFromGallery());
                        },
                        icon: Icon(
                          CupertinoIcons.photo_fill_on_rectangle_fill,
                          size: 30,
                          color: Theme.of(context).colorScheme.background,
                        )),
                  ),
                ],
              ),
                SizedBox(height: height * 0.04),
              BlocBuilder(
                bloc: _imagePickerBloc,
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ErrorState) {
                    return Center(
                      child: Text(state.error.toString()),
                    );
                  } else if (state is SuccessState) {
                    return ClipOval(
                      child: Image.file(
                        File(state.image!.path),
                        fit: BoxFit.cover,
                        width: width * 0.5,
                        height: height * 0.27,
                      ),
                    );
                  }
                  return Container(
                    width: width * 0.5,
                    height: height * 0.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
              SizedBox(height: height * 0.04),
              CustomButton(
                  width: width, height: height, onTap: () {}, text: 'Next')
            ],
          ),
        ),
      ),
    );
  }
}
