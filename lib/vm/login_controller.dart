// import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:private_gallery/providers/auth_provider.dart';
import 'package:private_gallery/utilities/dialogs/logout_dialog.dart';
import 'package:private_gallery/vm/login_state.dart';

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>(
  (ref) => LoginController(ref),
);

class LoginController extends StateNotifier<LoginState> {
  final Ref ref;
  LoginController(this.ref) : super(const LoginStateInitial());

  void signInWithGoogle(BuildContext context) async {
    state = const LoginStateLoading();
    try {
      await ref.read(authRepositoryProvider).signInWithGoogle();
      state = const LoginStateSuccess();
    } catch (e) {
      state = LoginStateFailure(e.toString());
    }
  }

  void signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const LoginStateLoading();
    try {
      await ref.read(authRepositoryProvider).signInWithEmail(
            email: email,
            password: password,
          );

      state = const LoginStateSuccess();
    } catch (e) {
      state = LoginStateFailure(e.toString());
    }
  }

  void signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      state = const LoginStateLoading();
      await ref.read(authRepositoryProvider).createUserWithEmail(
            email: email,
            password: password,
          );

      state = const LoginStateNeedsVerification();
    } catch (e) {
      state = LoginStateFailure(e.toString());
    }
  }

  void sendEmailVerification() async {
    try {
      await ref.read(authRepositoryProvider).sendEmailVerification();

      state = const LoginStateInitial();
    } catch (e) {
      state = LoginStateFailure(e.toString());
    }
  }

  void sendPasswordReset(String toEmail) async {
    try {
      state = const LoginStateLoading();
      await ref
          .read(authRepositoryProvider)
          .sendPasswordReset(toEmail: toEmail);

      state = const LoginStateInitial();
    } catch (e) {
      state = LoginStateFailure(e.toString());
    }
  }

  void logOut(BuildContext context) async {
    final shouldLogout = await showLogOutDialog(context);
    if (shouldLogout) {
      state = const LoginStateLoading();
      await ref.read(authRepositoryProvider).logOut();
    } else {
      return null;
    }
    state = const LoginStateInitial();
  }
}
