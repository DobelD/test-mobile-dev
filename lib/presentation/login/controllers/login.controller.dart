import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testmobiledev/domain/core/model/user_model.dart';
import 'package:testmobiledev/infrastructure/navigation/routes.dart';
import 'package:testmobiledev/utils/app_preference.dart';

import '../../../domain/core/interfaces/user_repository.dart';
import '../../../domain/core/model/login_param.dart';

enum LoginStatus { initial, loading, success, failed }

class LoginController extends GetxController {
  final UserRepository _userRepository;
  LoginController(this._userRepository);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var loginStatus = Rx<LoginStatus>(LoginStatus.initial);
  final formKey = GlobalKey<FormState>();
  var isObscureText = true.obs;

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      loginStatus.value = LoginStatus.loading;
      var loginParam = LoginParam(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      final user = await _userRepository.loginWithPassword(loginParam);

      if (user != null) {
        var dataUser = UserModel(
            name: user.additionalUserInfo?.profile?['name'],
            email: user.additionalUserInfo?.profile?['email'],
            picture: user.additionalUserInfo?.profile?['picture']);
        AppPreference().saveAccessToken(user.user?.uid ?? '');
        AppPreference().saveUserModel(dataUser);
        loginStatus.value = LoginStatus.success;
        Get.offAllNamed(Routes.MAIN_PAGES);
      } else {
        loginStatus.value = LoginStatus.failed;
      }
    }
  }

  Future<void> googleAuth() async {
    final user = await _userRepository.loginWithGoogle();
    if (user?.credential != null) {
      var dataUser = UserModel(
          name: user?.additionalUserInfo?.profile?['name'],
          email: user?.additionalUserInfo?.profile?['email'],
          picture: user?.additionalUserInfo?.profile?['picture']);
      AppPreference().saveAccessToken(user?.credential?.accessToken ?? '');
      AppPreference().saveUserModel(dataUser);
      Future.delayed(2.seconds, () {
        Get.offAllNamed(Routes.MAIN_PAGES);
      });
    }
  }

  Future<void> facebookAuth() async {
    final user = await _userRepository.loginWithFacebook();
    if (user?.credential != null) {
      var dataUser = UserModel(
          name: user?.user?.displayName,
          email: user?.user?.email,
          picture: user?.additionalUserInfo?.profile?['picture']['data']
              ['url']);
      AppPreference().saveAccessToken(user?.credential?.accessToken ?? '');
      AppPreference().saveUserModel(dataUser);
      Future.delayed(2.seconds, () {
        Get.offAllNamed(Routes.MAIN_PAGES);
      });
    }
  }

  String? validateUsername(String username) {
    if (username.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    } else if (password.length < 6) {
      return 'Password must be at least 6 characters';
    } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(password)) {
      return '''
Password must contain at least one uppercase letter,
one lowercase letter, and one digit
''';
    } else {
      return null;
    }
  }

  void suffixPasswordOnTap() {
    isObscureText.value = !isObscureText.value;
  }
}
