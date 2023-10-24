import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../domain/core/interfaces/user_repository.dart';
import '../../../domain/core/model/login_param.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<UserCredential?> loginWithPassword(LoginParam login) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: login.email, password: login.password);
      // ignore: unnecessary_null_comparison
      if (credential != null) {
        return credential;
      } else {
        return null;
      }
    } catch (error) {
      throw "Failed to login";
    }
  }

  @override
  Future<UserCredential?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? gAuth = await account?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth?.accessToken, idToken: gAuth?.idToken);
      final user = await FirebaseAuth.instance.signInWithCredential(credential);
      return user;
    } catch (e) {
      throw "Failet to login";
    }
  }

  @override
  Future<UserCredential?> loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken?.token ?? '');
      final user = await FirebaseAuth.instance.signInWithCredential(credential);
      return user;
    } catch (e) {
      throw "Failet to login";
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw "Failet to logout";
    }
  }
}
