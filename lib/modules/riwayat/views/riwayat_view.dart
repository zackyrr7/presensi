import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/riwayat/controller/riwayat_hitung_controller.dart';
import 'package:gopresent/modules/riwayat/widget/grid_riwayat.dart';

class RiwayatView extends StatelessWidget {
  RiwayatView({super.key});
  final RiwayatHitungController riwayatHitungController =
      Get.find<RiwayatHitungController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Riwayat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ),
      body: Column(
        children: [
          GridRiwayat(),
          Expanded(
            child: Obx(() {
              if (riwayatHitungController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: riwayatHitungController.listRiwayat.length,

                  itemBuilder: (context, index) {
                    if (riwayatHitungController.listRiwayat[index].sakit ==
                        '1') {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        child: Container(
                          // width: Get.width * 0.2,
                          height: Get.height * 0.1,
                          color: Theme.of(context).colorScheme.secondary,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(radius: 30),
                                SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      riwayatHitungController
                                          .listRiwayat[index]
                                          .tanggal,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyMedium?.color,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [Text('sakit')],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (riwayatHitungController
                            .listRiwayat[index]
                            .cuti ==
                        '1') {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        child: Container(
                          // width: Get.width * 0.2,
                          height: Get.height * 0.1,
                          color: Theme.of(context).colorScheme.secondary,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(radius: 30),
                                SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      riwayatHitungController
                                          .listRiwayat[index]
                                          .tanggal,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyMedium?.color,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [Text('Cuti')],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        child: Container(
                          // width: Get.width * 0.2,
                          height: Get.height * 0.1,
                          color: Theme.of(context).colorScheme.secondary,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(radius: 30),
                                SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      riwayatHitungController
                                          .listRiwayat[index]
                                          .tanggal,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyMedium?.color,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('Masuk'),
                                        SizedBox(width: 8),
                                        Text(':'),
                                        SizedBox(width: 8),
                                        Text(
                                          riwayatHitungController
                                              .listRiwayat[index]
                                              .jamMasuk,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Pulang'),
                                        SizedBox(width: 8),
                                        Text(':'),
                                        SizedBox(width: 8),
                                        Text(
                                          riwayatHitungController
                                              .listRiwayat[index]
                                              .jamKeluar,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
