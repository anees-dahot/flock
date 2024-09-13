import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageGridWidget extends StatelessWidget {
  final List<String> images;

  const ImageGridWidget({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const SizedBox
          .shrink(); // Return an empty widget if there are no images
    } else if (images.length == 1) {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
        child: CachedNetworkImage(
          imageUrl: images.first,
          fit: BoxFit.cover,
          height: 200, // You can adjust this height as needed
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: images.length == 2 ? 2 : 3,
            childAspectRatio: 1.0,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          itemCount: images.length > 4 ? 4 : images.length,
          itemBuilder: (context, index) {
            if (index == 3 && images.length > 4) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: images[index],
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.7),
                    child: Center(
                      child: Text(
                        '+${images.length - 4}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              );
            }
            return CachedNetworkImage(
              imageUrl: images[index],
              fit: BoxFit.cover,
            );
          },
        ),
      );
    }
  }
}
