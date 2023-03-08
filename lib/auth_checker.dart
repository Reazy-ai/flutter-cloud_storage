import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:private_gallery/providers/auth_provider.dart';
import 'package:private_gallery/views/auth_views/login_screen.dart';
import 'package:private_gallery/views/auth_views/verify_email_screen.dart';
import 'package:private_gallery/views/storage_views/storage_home_view.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);

    return _authState.when(
        data: (user) {
          if (user != null && user.emailVerified) {
            return const StorageScreen();
          } else if (user != null && !user.emailVerified) {
            return const VerifyEmailScreen();
          } else {
            return const LoginScreen();
          }
        },
        error: (error, stackTrace) => const ErrorPage(),
        loading: () => const CircularProgressIndicator.adaptive()
        // const LoadingPage()
        // LoadingScreen().show(context: context, text: 'Please wait') as Widget,
        );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Error'),
      ),
    );
  }
}
