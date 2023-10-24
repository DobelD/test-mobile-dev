import 'package:get/get.dart';

import '../../../../presentation/camera_page/controllers/camera_page.controller.dart';

class CameraPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraPageController>(
      () => CameraPageController(),
    );
  }
}
