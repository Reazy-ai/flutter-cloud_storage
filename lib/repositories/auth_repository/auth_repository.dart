import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:private_gallery/services/auth/auth_exceptions.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  const AuthRepository(this._auth);

  Stream<User?> get authStateChange => _auth.authStateChanges();
  User? get user => _auth.currentUser;

  Future signInWithGoogle() async {
    await _firebaseSignInWithCredential();
  }

  Future<UserCredential> _firebaseSignInWithCredential() async {
    final googleSignIn = GoogleSignIn(scopes: ['email']);
    final googleSignInAccount = await googleSignIn.signIn();
    final googleSignInAuth = await googleSignInAccount?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth?.accessToken,
        idToken: googleSignInAuth?.idToken);
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential;
    } on FirebaseAuthException {
      throw GenericAuthException();
    }
  }

  Future createUserWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCred.user?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  Future signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  Future<void> sendPasswordReset({required String toEmail}) async {
    try {
      await _auth.sendPasswordResetEmail(email: toEmail);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'firebase_auth/invalid-email':
          throw InvalidEmailAuthException();
        case 'firebase_auth/user-not-found':
          throw UserNotFoundAuthException();
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  Future<void> logOut() async {
    final googleSignIn = GoogleSignIn();

    if (user != null) {
      try {
        await googleSignIn.signOut();
        await _auth.signOut();
      } on FirebaseAuthException {
        throw GenericAuthException();
      }
    } else {
      throw UserNotLoggedInAuthException();
    }
  }
}
