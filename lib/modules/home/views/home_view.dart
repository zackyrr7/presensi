import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/auth/controllers/reset_controller.dart';
import 'package:gopresent/modules/home/controllers/home_controller.dart';
import 'package:gopresent/modules/home/widget/card_masuk_pulang.dart';
import 'package:gopresent/modules/home/widget/grid_container.dart';
import 'package:gopresent/modules/home/widget/home_bottomSheet.dart';
import 'package:gopresent/modules/home/widget/presensi_today.dart';
import 'package:gopresent/services/theme_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final themeService = Get.find<ThemeService>();
  final homeController = Get.find<HomeController>();
  final resetController = Get.find<ResetController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed('/notification');
                    },
                    icon: Icon(Icons.notifications, size: 30),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Mengubah tema ketika tombol ditekan
                        themeService.switchTheme();
                      },
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Obx(() {
                          return Icon(
                            size: 30,
                            // Mengubah ikon sesuai dengan status tema
                            themeService.isDarkMode.value
                                ? Icons
                                    .light_mode // Ikon untuk tema gelap
                                : Icons
                                    .dark_mode_outlined, // Ikon untuk tema terang
                          );
                        }),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        resetController.resetHome();
                      },
                      icon: Icon(Icons.refresh, size: 30),
                    ),
                  ],
                ),
              ],
            ),
            //Container nama dan perusahaan
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                height: Get.height * 0.1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimaryFixed,
                        radius: 25,
                        child: Icon(
                          Icons.person,
                          size: 40,
                        ), // Menyesuaikan ukuran ikon
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() {
                              if (homeController.isLoading.value) {
                                return LoadingAnimationWidget.staggeredDotsWave(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.onPrimaryFixed,
                                  size: 12,
                                );
                              }
                              return Text(
                                homeController.nama.string,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              );
                            }),
                            Row(
                              children: [
                                Icon(Icons.shopping_bag),
                                SizedBox(width: 5),

                                Obx(() {
                                  if (homeController.isLoading.value) {
                                    return LoadingAnimationWidget.staggeredDotsWave(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onPrimaryFixed,
                                      size: 20,
                                    );
                                  }
                                  return Text(
                                    homeController.perusahaan.string,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  );
                                }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CardMasukPulang(),
            SizedBox(height: 10),
            GridContainer(),
            PresensiToday(),
          ],
        ),
      ),
    );
  }
}
