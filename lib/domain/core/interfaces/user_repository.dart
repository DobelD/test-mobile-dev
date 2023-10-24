import 'package:firebase_auth/firebase_auth.dart';
import '../model/login_param.dart';

abstract class UserRepository {
  Future<UserCredential?> loginWithPassword(LoginParam login);
  Future<UserCredential?> loginWithGoogle();
  Future<UserCredential?> loginWithFacebook();
  Future<void> logOut();
}
