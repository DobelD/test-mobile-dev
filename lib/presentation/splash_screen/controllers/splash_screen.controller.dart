import 'package:get/get.dart';
import 'package:testmobiledev/infrastructure/navigation/routes.dart';
import 'package:testmobiledev/utils/app_preference.dart';

class SplashScreenController extends GetxController {
  Future<void> checkAccess() async {
    await Future.delayed(2.seconds, () {
      final authentification = AppPreference().getAccessToken();
      if (authentification != null) {
        Get.offAllNamed(Routes.MAIN_PAGES);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
  }
}
