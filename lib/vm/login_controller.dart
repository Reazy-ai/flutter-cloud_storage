// import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:private_gallery/helpers/loading/loading_overlay.dart';
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
      LoadingScreen().show(context: context, text: 'Please wait');
      await ref.read(authRepositoryProvider).signInWithGoogle();
      state = const LoginStateSuccess();
    } catch (e) {
      state = LoginStateFailure(e.toString());
    }
    LoadingScreen().hide();
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

      state = const LoginStateSuccess();
    } catch (e) {
      state = LoginStateFailure(e.toString());
    }
  }

  void sendEmailVerification() async {
    try {
      await ref.read(authRepositoryProvider).sendEmailVerification();

      state = const LoginStateSuccess();
    } catch (e) {
      state = LoginStateFailure(e.toString());
    }
  }

  void sendPasswordReset(String toEmail) async {
    try {
      await ref
          .read(authRepositoryProvider)
          .sendPasswordReset(toEmail: toEmail);

      state = const LoginStateSuccess();
    } catch (e) {
      state = LoginStateFailure(e.toString());
    }
  }

  void logOut(BuildContext context) async {
    state = const LoginStateLoading();
    await showLogOutDialog(context).then((value) async {
      value ? await ref.read(authRepositoryProvider).logOut() : null;
      state = const LoginStateInitial();
    });
    // if (shouldLogOut) {
    //   ;
    //   state = const LoginStateInitial();
    // }
  }
}
