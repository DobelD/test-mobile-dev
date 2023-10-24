import 'package:get/get.dart';
import 'package:testmobiledev/infrastructure/dal/repositories/karyawan_repository_impl.dart';
import 'package:testmobiledev/infrastructure/dal/repositories/user_repository_impl.dart';

import '../../../../presentation/home/controllers/home.controller.dart';

class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(UserRepositoryImpl(), KaryawanRepositoryImpl()),
    );
  }
}
