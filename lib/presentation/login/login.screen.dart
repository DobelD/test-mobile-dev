import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/login.controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
                controller: controller.emailController,
                decoration: InputDecoration(
                    hintText: "Email",
                    enabledBorder: _border,
                    border: _border,
                    focusedBorder: _focusedBorder,
                    prefixIcon: const Icon(Icons.person)),
                validator: (String? value) =>
                    controller.validateUsername(value ?? ''),
                autovalidateMode: AutovalidateMode.onUserInteraction),
            const SizedBox(height: 12),
            Obx(() {
              return TextFormField(
                  controller: controller.passwordController,
                  obscureText: controller.isObscureText.value,
                  decoration: InputDecoration(
                      hintText: "Password",
                      enabledBorder: _border,
                      border: _border,
                      focusedBorder: _focusedBorder,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () => controller.suffixPasswordOnTap(),
                        icon: Icon(controller.isObscureText.isTrue
                            ? Icons.visibility_off
                            : Icons.visibility),
                      )),
                  validator: (String? value) =>
                      controller.validatePassword(value ?? ''),
                  autovalidateMode: AutovalidateMode.onUserInteraction);
            }),
            const SizedBox(height: 22),
            SizedBox(
              width: Get.width,
              height: 46,
              child: Obx(() {
                final loginStatus = controller.loginStatus.value;
                if (loginStatus == LoginStatus.loading) {
                  return ElevatedButton(
                    onPressed: () {},
                    child: const Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    )),
                  );
                } else {
                  return ElevatedButton(
                    onPressed: () => controller.login(),
                    child: const Text('Login'),
                  );
                }
              }),
            ),
            const SizedBox(height: 42),
            SizedBox(
                width: Get.width,
                height: 48,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26)),
                        backgroundColor: Colors.white),
                    onPressed: () => controller.googleAuth(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/google.png',
                            height: 36, width: 36),
                        const SizedBox(width: 8),
                        const Text(
                          'Sign in with Goolge',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ))),
            const SizedBox(height: 16),
            SizedBox(
                width: Get.width,
                height: 48,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26)),
                        backgroundColor: const Color.fromARGB(255, 0, 72, 255)),
                    onPressed: () => controller.facebookAuth(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/fb.png',
                            height: 36, width: 36),
                        const SizedBox(width: 8),
                        const Text('Sign in with Facebook')
                      ],
                    ))),
          ],
        ),
      ),
    ));
  }

  OutlineInputBorder get _border {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300));
  }

  OutlineInputBorder get _focusedBorder {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue));
  }
}
