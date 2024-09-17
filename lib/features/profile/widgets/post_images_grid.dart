import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget buildImageLayout(List<String> images) {
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
        const SizedBox(height: 8),
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
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: images.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 4, // Show only 4 images in the grid
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return CachedNetworkImage(
              imageUrl: images[index],
              fit: BoxFit.cover,
            );
          },
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'View all ${images.length} photos',
            style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
