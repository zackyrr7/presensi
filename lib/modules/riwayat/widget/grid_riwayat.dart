import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/riwayat/controller/riwayat_hitung_controller.dart';

class GridRiwayat extends StatelessWidget {
  GridRiwayat({super.key});
  final RiwayatHitungController riwayatHitungController =
      Get.find<RiwayatHitungController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: Get.height * 0.1,
                width: Get.width * 0.4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hadir',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ),

                    Obx(() {
                      return Text(
                        '${riwayatHitungController.hadir.string} hari',
                      );
                    }),
                  ],
                ),
              ),
              Container(
                height: Get.height * 0.1,
                width: Get.width * 0.4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Telat',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),

                    Obx(() {
                      return Text(
                        '${riwayatHitungController.telat.string} hari',
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: Get.height * 0.1,
                width: Get.width * 0.4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Izin',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.amber,
                      ),
                    ),

                    Obx(() {
                      return Text(
                        '${riwayatHitungController.izin.string} hari',
                      );
                    }),
                  ],
                ),
              ),
              Container(
                height: Get.height * 0.1,
                width: Get.width * 0.4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sakit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),

                    Obx(() {
                      return Text(
                        '${riwayatHitungController.sakit.string} hari',
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
