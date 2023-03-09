import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:private_gallery/providers/auth_repository_provider.dart';
import 'package:private_gallery/providers/isLoading_provider.dart';
import 'package:private_gallery/utilities/loading/loading_overlay.dart';
import 'package:private_gallery/views/auth_views/login_screen.dart';
import 'package:private_gallery/views/auth_views/verify_email_screen.dart';
import 'package:private_gallery/views/storage_views/storage_home_view.dart';
import 'package:private_gallery/vm/login_controller.dart';
import 'package:private_gallery/vm/login_state.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(isLoadingProvider, (_, loadingState) {
      if (loadingState) {
        LoadingScreen().show(context: context, text: 'Please wait');
      } else {
        LoadingScreen().hide();
      }
    });

    final authState = ref.watch(loginControllerProvider);

    return StreamBuilder(
      stream: ref.watch(authRepositoryProvider).authStateChange,
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user != null &&
            user.emailVerified &&
            (authState is LoginStateSuccess)) {
          return const StorageScreen();
        } else if (user != null &&
            (!user.emailVerified || authState is LoginStateNeedsVerification)) {
          return const VerifyEmailScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
