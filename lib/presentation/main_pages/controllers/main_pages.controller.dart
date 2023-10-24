import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testmobiledev/infrastructure/dal/repositories/karyawan_repository_impl.dart';
import 'package:testmobiledev/infrastructure/dal/repositories/user_repository_impl.dart';
import 'package:testmobiledev/presentation/camera_page/controllers/camera_page.controller.dart';
import 'package:testmobiledev/presentation/home/controllers/home.controller.dart';
import 'package:testmobiledev/presentation/screens.dart';

class MainPagesController extends GetxController {
  var tabIndex = 0;

  changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  List<Widget> pages = [const HomeScreen(), const CameraPageScreen()];
  initControllerPage() {
    Get.put(HomeController(UserRepositoryImpl(), KaryawanRepositoryImpl()));
    Get.put(CameraPageController());
  }

  @override
  void onInit() {
    initControllerPage();
    super.onInit();
  }
}
