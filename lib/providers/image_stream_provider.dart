import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:private_gallery/models/cloud_file.dart';
import 'package:private_gallery/providers/storage_controller_provider.dart';

final imageStreamProvider =
    StreamProvider.family<List<CloudFile>, String>((ref, ownerUserId) {
  return ref
      .watch(storageControllerProvider.notifier)
      .retrieveImages(ownerUserId: ownerUserId);
});
