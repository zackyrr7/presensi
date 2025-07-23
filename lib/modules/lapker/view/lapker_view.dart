import 'package:flutter/material.dart';
import 'package:gopresent/modules/lapker/controller/lapker_controller.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/lapker/widget/add_lapker.dart';

class LapkerView extends StatelessWidget {
  LapkerView({super.key});
  final LapkerController lapkerController = Get.find<LapkerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Laporan Kerja',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              lapkerController.getLapker();
              // todolistController.resetFilter();
              // todolistController.getTodoList();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Obx(() {
        if (lapkerController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bulan',
                                    style: TextStyle(
                                      fontSize: 16,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    lapkerController.bulanIndo,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  List<String> namaBulan = [
                                    'Januari',
                                    'Februari',
                                    'Maret',
                                    'April',
                                    'Mei',
                                    'Juni',
                                    'Juli',
                                    'Agustus',
                                    'September',
                                    'Oktober',
                                    'November',
                                    'Desember',
                                  ];
                                  Get.defaultDialog(
                                    title: 'Pilih Bulan',
                                    content: SizedBox(
                                      height: Get.height * 0.7,
                                      width: Get.width * 0.8,
                                      child: ListView.builder(
                                        itemCount: namaBulan.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            title: Text(namaBulan[index]),
                                            onTap: () {
                                              lapkerController.bulan.value =
                                                  (index + 1);
                                              Get.back();
                                              lapkerController.getLapker();
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    cancel: Align(
                                      alignment: Alignment.bottomRight,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text('Batal'),
                                      ),
                                    ),
                                  );
                                },
                                splashColor: Colors.blue.withOpacity(
                                  0.3,
                                ), // warna efek cipratan
                                highlightColor: Colors.blue.withOpacity(
                                  0.1,
                                ), // warna saat ditekan
                                borderRadius: BorderRadius.circular(
                                  8,
                                ), // opsional
                                child: Container(
                                  // padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color:
                                        Colors
                                            .grey
                                            .shade200, // warna background
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      List<String> namaBulan = [
                                        'Januari',
                                        'Februari',
                                        'Maret',
                                        'April',
                                        'Mei',
                                        'Juni',
                                        'Juli',
                                        'Agustus',
                                        'September',
                                        'Oktober',
                                        'November',
                                        'Desember',
                                      ];
                                      Get.defaultDialog(
                                        title: 'Pilih Bulan',
                                        content: SizedBox(
                                          height: Get.height * 0.7,
                                          width: Get.width * 0.8,
                                          child: ListView.builder(
                                            itemCount: namaBulan.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                title: Text(namaBulan[index]),
                                                onTap: () {
                                                  lapkerController.bulan.value =
                                                      (index + 1);
                                                  Get.back();
                                                  lapkerController.getLapker();
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        cancel: Align(
                                          alignment: Alignment.bottomRight,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text('Batal'),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.calendar_today,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hari, Tanggal',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Jumlah',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 10,),
                      Divider(),
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder:
                              (context, index) => Divider(
                                color: Colors.grey.shade300,
                                height: 1,
                                thickness: 1,
                              ),
                          itemCount: lapkerController.lapkerList.length,
                          itemBuilder: (context, index) {
                            final item = lapkerController.lapkerList[index];
                            return ListTile(
                              title: Text(item.tanggalIndonesia),
                              trailing: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 30,
                                width: 30,

                                // margin: EdgeInsets.all(12),
                                child: Center(
                                  child: Text(
                                    item.detail.length.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                // Handle tap if needed
                                Get.toNamed('/lapker-detail', arguments: item);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(AddLapker());
        },
        backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
        child: Icon(Icons.add),
      ),
    );
  }
}
