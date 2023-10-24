import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/splash_screen.controller.dart';

class SplashScreenScreen extends GetView<SplashScreenController> {
  const SplashScreenScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: controller.checkAccess(),
          builder: (context, snap) {
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
