import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:private_gallery/repositories/storage_repository.dart';

final storageRepositoryProvider = Provider<StorageRepository>(
  (ref) {
    return StorageRepository();
  },
);
