import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/home/controllers/home_controller.dart';
import 'dart:math';

class PresensiToday extends StatelessWidget {
  PresensiToday({super.key});
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  onTap: () {
                    Get.toNamed('/today-absen');
                  },
                  child: Text(
                    'Lihat semua',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
          ),

          Obx(() {
            if (homeController.isLoading2.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Column(
                children: List.generate(
                  min(homeController.listAbsensToday.length, 5),
                  (index) {
                    final item = homeController.listAbsensToday[index];
                    //  String jamkeluar = item.jamKeluar ?? '00:00:00';
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(15, 4, 15, 4),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.color,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Absen Masuk'),
                                Text(item.jamMasuk),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Absen Pulang'),
                                Text(
                                  (item.jamKeluar?.isEmpty ?? true)
                                      ? '00:00:00'
                                      : item.jamKeluar!,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
