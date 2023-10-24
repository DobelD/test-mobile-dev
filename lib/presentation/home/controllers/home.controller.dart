import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:testmobiledev/infrastructure/navigation/routes.dart';

import '../../../domain/core/interfaces/karyawan_repository.dart';
import '../../../domain/core/interfaces/user_repository.dart';
import '../../../domain/core/model/karyawan_model.dart';
import '../../../domain/core/model/karyawan_param.dart';
import '../../../utils/app_preference.dart';

enum HomeStatus { initial, loading, success, failed }

class HomeController extends GetxController {
  final UserRepository _userRepository;
  final KaryawanRepository _karyawanRepository;
  HomeController(this._userRepository, this._karyawanRepository);

  var nameController = TextEditingController();
  var alamatController = TextEditingController();
  var positionController = TextEditingController();
  var statusController = TextEditingController();

  late CacheManager customCacheManager;
  final userModels = AppPreference().getUserModel();
  var homeStatus = Rx<HomeStatus>(HomeStatus.initial);
  var karyawans = <KaryawanModel>[].obs;
  var loadingOnAction = false.obs;
  var loadingPage = false.obs;

  var isEdit = false.obs;

  Future<void> getKaryawan() async {
    homeStatus(HomeStatus.loading);
    final karyawan = await _karyawanRepository.getKaryawan();
    if (karyawan != null) {
      karyawans.assignAll(karyawan);
      homeStatus(HomeStatus.success);
    }
    homeStatus(HomeStatus.failed);
  }

  Future<void> createKaryawan() async {
    loadingOnAction(true);
    var karyawanData = KaryawanParam(
        name: nameController.text.trim(),
        alamat: alamatController.text.trim(),
        position: positionController.text.trim(),
        status: statusController.text.trim());
    final karyawan = await _karyawanRepository.createKaryawan(karyawanData);
    if (karyawan != null) {
      loadingOnAction(false);
    } else {
      loadingOnAction(false);
    }
    Get.back();
    getKaryawan();
  }

  Future<void> updateKaryawan({required int id}) async {
    loadingOnAction(true);
    var karyawanData = KaryawanParam(
        name: nameController.text.trim(),
        alamat: alamatController.text.trim(),
        position: positionController.text.trim(),
        status: statusController.text.trim());
    final karyawan = await _karyawanRepository.updateKaryawan(karyawanData, id);
    if (karyawan != null) {
      loadingOnAction(false);
    } else {
      loadingOnAction(false);
    }
    Get.back();
    getKaryawan();
  }

  Future<void> deleteKaryawan({required int id, required String name}) async {
    Get.defaultDialog(
        middleText: "Delete $name ?",
        onCancel: () => Get.back(),
        onConfirm: () async {
          await _karyawanRepository.deleteKaryawan(id);
          Get.back();
          getKaryawan();
        });
  }

  clearTextController() {
    nameController.clear();
    alamatController.clear();
    positionController.clear();
    statusController.clear();
  }

  setKarwayanData(KaryawanModel data) {
    nameController = TextEditingController(text: data.nama);
    alamatController = TextEditingController(text: data.alamat);
    positionController = TextEditingController(text: data.posisi);
    statusController = TextEditingController(text: data.status);
  }

  Future<void> logout() async {
    loadingPage(true);
    await _userRepository.logOut();
    AppPreference().clearLocalStorage();
    Future.delayed(3.seconds, () {
      loadingPage(true);
      Get.offAllNamed(Routes.LOGIN);
    });
  }

  @override
  void onInit() {
    getKaryawan();
    customCacheManager = CacheManager(Config('customCacheKey',
        stalePeriod: 15.days, maxNrOfCacheObjects: 100));
    super.onInit();
  }
}
