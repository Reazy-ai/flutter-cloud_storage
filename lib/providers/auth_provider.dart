import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:private_gallery/repositories/auth_repository/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) {
    return AuthRepository(FirebaseAuth.instance);
  },
);

final authStateProvider = StreamProvider<User?>(
  (ref) {
    return ref.read(authRepositoryProvider).authStateChange;
  },
);

final currentUserIdProvider = Provider(
  (ref) {
    return ref.read(authRepositoryProvider).user!.uid;
  },
);
