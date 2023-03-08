import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:private_gallery/vm/login_controller.dart';

class VerifyEmailScreen extends ConsumerWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text(
            'An email verification link has been sent to the provided email, tap on the link to verify your email',
          ),
          const Text("Didn't get an email? Request below"),
          TextButton(
            onPressed: () {
              ref
                  .read(loginControllerProvider.notifier)
                  .sendEmailVerification();
            },
            child: const Text('Resend verification email'),
          ),
          TextButton(
            onPressed: () {
              ref.read(loginControllerProvider.notifier).logOut(context);
            },
            child: const Text('LogOut'),
          ),
        ],
      ),
    );
  }
}
