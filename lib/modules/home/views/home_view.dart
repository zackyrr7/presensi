import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/auth/controllers/reset_controller.dart';
import 'package:gopresent/modules/home/controllers/home_controller.dart';
import 'package:gopresent/modules/home/widget/card_masuk_pulang.dart';
import 'package:gopresent/modules/home/widget/home_bottomSheet.dart';
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
            SizedBox(
              height: Get.height * 0.23,
              width: Get.width,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/izin');
                            },
                            child: SizedBox(
                              height: Get.height * 0.08,
                              width: Get.height * 0.08,

                              child: Image.asset("assets/icon/izin.png"),
                            ),
                          ),
                          Text('Izin'),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              height: Get.height * 0.08,
                              width: Get.height * 0.08,

                              child: Image.asset("assets/icon/sakit.png"),
                            ),
                          ),
                          Text('Sakit'),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              height: Get.height * 0.08,
                              width: Get.height * 0.08,

                              child: Image.asset("assets/icon/cuti.png"),
                            ),
                          ),
                          Text('Cuti'),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              height: Get.height * 0.08,
                              width: Get.height * 0.08,

                              child: Image.asset("assets/icon/task.png"),
                            ),
                          ),
                          Text('Task'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              height: Get.height * 0.08,
                              width: Get.height * 0.08,

                              child: Image.asset("assets/icon/amal-yaumi.png"),
                            ),
                          ),
                          Text('Amal Yaumi'),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              height: Get.height * 0.08,
                              width: Get.height * 0.08,

                              child: Image.asset("assets/icon/lapker.png"),
                            ),
                          ),
                          Text('Aktivitas'),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              height: Get.height * 0.08,
                              width: Get.height * 0.08,

                              child: Image.asset("assets/icon/slip.png"),
                            ),
                          ),
                          Text('Slip Gaji'),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.bottomSheet(HomeBottomSheet());
                            },
                            child: SizedBox(
                              height: Get.height * 0.08,
                              width: Get.height * 0.08,

                              child: Image.asset("assets/icon/lainnya.png"),
                            ),
                          ),
                          Text('Lainnya'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              // height: Get.height * 0.2,
              width: Get.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Absensi Hari Ini',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Lihat semua',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
