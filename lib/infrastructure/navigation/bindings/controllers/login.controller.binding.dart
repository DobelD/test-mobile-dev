import 'package:get/get.dart';
import 'package:testmobiledev/infrastructure/dal/repositories/user_repository_impl.dart';

import '../../../../presentation/login/controllers/login.controller.dart';

class LoginControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(UserRepositoryImpl()),
    );
  }
}
