import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:testmobiledev/components/app_body.dart';

import 'controllers/home.controller.dart';
import 'section/form_karyawan.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // ignore: unrelated_type_equality_checks
      var status = controller.homeStatus == HomeStatus.loading ? true : false;

      return AppBody(
        isLoading: controller.loadingPage.value,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            title: Row(
              children: [
                CachedNetworkImage(
                  key: UniqueKey(),
                  cacheManager: controller.customCacheManager,
                  imageUrl: controller.userModels?.picture ?? '',
                  height: 38,
                  width: 38,
                  fit: BoxFit.cover,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    );
                  },
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) {
                    return const Icon(
                      Icons.error,
                      color: Colors.red,
                    );
                  },
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.userModels?.name ?? 'Name is null',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.userModels?.email ?? 'Email is null',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                )
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () => controller.logout(),
                  icon: const Icon(Icons.logout_rounded, color: Colors.grey))
            ],
          ),
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                controller.clearTextController();
                controller.isEdit(false);
                Get.bottomSheet(
                    enterBottomSheetDuration: 300.milliseconds,
                    exitBottomSheetDuration: 300.milliseconds,
                    isScrollControlled: true,
                    const FormKaryawanSection());
              }),
          body: status
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(2.seconds, () {
                      controller.getKaryawan();
                    });
                  },
                  child: ListView.builder(
                      itemCount: controller.karyawans.length,
                      itemBuilder: (_, index) {
                        var karyawan = controller.karyawans[index];
                        return ListTile(
                          title: Text(karyawan.nama ?? ''),
                          subtitle: Text(karyawan.posisi ?? ''),
                          trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        controller.setKarwayanData(karyawan);
                                        controller.isEdit(true);
                                        Get.bottomSheet(
                                            enterBottomSheetDuration:
                                                300.milliseconds,
                                            exitBottomSheetDuration:
                                                300.milliseconds,
                                            isScrollControlled: true,
                                            FormKaryawanSection(
                                                id: karyawan.id ?? 0));
                                      },
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () =>
                                          controller.deleteKaryawan(
                                              id: karyawan.id ?? 0,
                                              name: karyawan.nama ?? ''),
                                      icon: const Icon(Icons.delete))
                                ],
                              )),
                        );
                      }),
                ),
        ),
      );
    });
  }
}
