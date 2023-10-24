import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/camera_page.controller.dart';

class CameraPageScreen extends GetView<CameraPageController> {
  const CameraPageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CameraPageController>(
        init: CameraPageController(),
        builder: (context) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  controller.imageFile == null ? 'Camera' : 'Preview',
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
                backgroundColor: Colors.white,
                elevation: 1,
                actions: [
                  SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () => controller.switchCamera(),
                            icon: Icon(
                              Icons.change_circle_rounded,
                              color: Colors.grey.shade500,
                            )),
                        IconButton(
                            onPressed: () => controller.togleFlashCamera(),
                            icon: Icon(
                                controller.flashCamera
                                    ? Icons.flash_on
                                    : Icons.flash_off,
                                color: Colors.grey.shade500))
                      ],
                    ),
                  )
                ],
              ),
              body: controller.isCameraInitialized.isFalse
                  ? SizedBox(
                      height: Get.height,
                      child: Column(
                        children: [
                          Flexible(
                              flex: 10,
                              child: controller.imageFile == null
                                  ? SizedBox(
                                      child: CameraPreview(
                                          controller.cameraController))
                                  : Image.file(
                                      File(controller.imageFile?.path ?? ''))),
                          Flexible(
                              flex: 2,
                              child: Container(
                                width: Get.width,
                                color: Colors.white,
                                padding: const EdgeInsets.all(16),
                                child: GestureDetector(
                                    onTap: controller.imageFile == null
                                        ? () => controller.captureImage()
                                        : () => controller.deletePreview(),
                                    child: controller.imageFile == null
                                        ? const CircleAvatar(
                                            radius: 32,
                                            backgroundColor: Colors.blue,
                                            child: Icon(Icons.camera),
                                          )
                                        : CircleAvatar(
                                            radius: 32,
                                            backgroundColor: Colors.white,
                                            foregroundColor:
                                                Colors.grey.shade400,
                                            child: const Icon(Icons.close))),
                              ))
                        ],
                      ),
                    )
                  : const Center(child: CircularProgressIndicator()));
        });
  }
}
