import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:private_gallery/models/cloud_file.dart';

class FullImageScreen extends StatelessWidget {
  final List<CloudFile> images;
  final PageController controller;
  final VoidCallback onTap;
  const FullImageScreen({
    Key? key,
    required this.images,
    required this.controller,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(child: const Text('Delete'), onTap: onTap),
              ];
            },
          )
        ],
      ),
      body: PhotoViewGallery.builder(
        itemCount: images.length,
        pageController: controller,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(images[index].fileUrl),
          );
        },
      ),
    );
  }
}
