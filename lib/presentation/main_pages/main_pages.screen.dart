import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/main_pages.controller.dart';

class MainPagesScreen extends GetView<MainPagesController> {
  const MainPagesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: MainPagesController(),
        builder: (_) {
          return Scaffold(
            body: IndexedStack(
                index: controller.tabIndex, children: controller.pages),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: controller.tabIndex,
                onTap: controller.changeTabIndex,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
                  BottomNavigationBarItem(icon: Icon(Icons.image), label: "")
                ]),
          );
        });
  }
}
