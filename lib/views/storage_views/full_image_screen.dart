import 'package:flutter/material.dart';
import 'package:private_gallery/models/cloud_file.dart';

class FullImageScreen extends StatelessWidget {
  final CloudFile image;
  const FullImageScreen({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.network(
          image.fileUrl,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
