import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:private_gallery/models/cloud_file.dart';

class UserFilesRepository {
  final storedImages = FirebaseFirestore.instance.collection('images');
  final storedVideos = FirebaseFirestore.instance.collection('videos');

  Future uploadImage(CloudFile file) async {
    // Save the file to the database
    final uploadedFile = await storedImages.add(file.toMap());

    // get the file as stored on the database in order to get the generated document id of the file
    final uploadedImage = await uploadedFile.get();

    //extract the generated id
    final fileId = uploadedImage.id;

    // update the "fileId" field of the stored file with the extracted id
    await storedImages.doc(fileId).update({"fileId": fileId});
  }

  Future uploadVideo(CloudFile file) async {
    await storedVideos.add(file.toMap());
  }

  // Stream of User images.
  Stream<List<CloudFile>> retrieveImages({required String ownerUserId}) {
    return storedImages
        .where('ownerUserId', isEqualTo: ownerUserId)
        .snapshots()
        .map(
          (event) =>
              event.docs.map((img) => CloudFile.fromMap(img.data())).toList(),
        );
  }

// Stream of User videos.
  Stream<List<CloudFile>> retrieveVideos({required String ownerUserId}) {
    return storedVideos
        .where('ownerUserId', isEqualTo: ownerUserId)
        .snapshots()
        .map(
          (event) =>
              event.docs.map((vids) => CloudFile.fromMap(vids.data())).toList(),
        );
  }

  void deleteImage({required String fileId}) async {
    await storedImages.doc(fileId).delete();
  }
}
