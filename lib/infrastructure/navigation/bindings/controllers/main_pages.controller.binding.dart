import 'package:get/get.dart';

import '../../../../presentation/main_pages/controllers/main_pages.controller.dart';

class MainPagesControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPagesController>(
      () => MainPagesController(),
    );
  }
}
