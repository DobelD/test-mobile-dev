import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home.controller.dart';

class FormKaryawanSection extends StatelessWidget {
  const FormKaryawanSection({super.key, this.id});

  final int? id;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Container(
      padding: const EdgeInsets.all(12),
      height: Get.height * 0.5,
      color: Colors.white,
      child: Column(
        children: [
          TextFormField(
            controller: controller.nameController,
            decoration: InputDecoration(
                hintText: "Name...",
                border: _border,
                enabledBorder: _border,
                focusedBorder: _focusedBorder),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller.alamatController,
            decoration: InputDecoration(
                hintText: "Alamat...",
                border: _border,
                enabledBorder: _border,
                focusedBorder: _focusedBorder),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller.positionController,
            decoration: InputDecoration(
                hintText: "Posisi...",
                border: _border,
                enabledBorder: _border,
                focusedBorder: _focusedBorder),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller.statusController,
            decoration: InputDecoration(
                hintText: "Status...",
                border: _border,
                enabledBorder: _border,
                focusedBorder: _focusedBorder),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 42,
            width: Get.width,
            child: Obx(() {
              return ElevatedButton(
                  onPressed: () {
                    if (controller.isEdit.isFalse) {
                      controller.createKaryawan();
                    } else {
                      controller.updateKaryawan(id: id ?? 0);
                    }
                  },
                  child: controller.loadingOnAction.isTrue
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                      : Text(controller.isEdit.isFalse
                          ? 'Add Karyawan'
                          : 'Update Karyawan'));
            }),
          )
        ],
      ),
    );
  }

  OutlineInputBorder get _border {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300));
  }

  OutlineInputBorder get _focusedBorder {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue));
  }
}
