import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageRepository {
  final storage = FirebaseStorage.instance.ref();
  final storedImages = FirebaseFirestore.instance.collection('images');
  final storedVideos = FirebaseFirestore.instance.collection('videos');
  ImagePicker imagePicker = ImagePicker();

  Future<String> uploadPicture(
      {required File picture, required String path}) async {
    final uploadedImage = await storage.child(path).putFile(picture);
    final imageUrl = await uploadedImage.ref.getDownloadURL();
    return imageUrl;
  }

  Future<String> uploadVideo(
      {required File video, required String path}) async {
    final uploadedVideo = await storage.child(path).putFile(video);
    final videoUrl = await uploadedVideo.ref.getDownloadURL();
    return videoUrl;
  }
}
