import 'package:flutter/material.dart';
import 'package:gopresent/modules/cuti/controller/cuti_controller.dart';
import 'package:gopresent/modules/izin/controller/izin_controller.dart';
import 'package:get/get.dart';

class CutiView extends StatelessWidget {
  CutiView({super.key});

  final CutiController cutiController = Get.find<CutiController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cuti Pegawai',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              cutiController.getCuti();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Obx(() {
        if (cutiController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Column(
            children: [
              Container(
                height: Get.height * 0.13,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: Get.width * 0.23,
                      height: Get.width * 0.23,

                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Jumlah',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${cutiController.jumlah.value} Hari',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: Get.width * 0.23,
                      height: Get.width * 0.23,

                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Diambil',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${cutiController.diambil.value} Hari',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: Get.width * 0.23,
                      height: Get.width * 0.23,

                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sisa',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${cutiController.sisa.value} Hari',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: cutiController.modelCuti.length,
                  itemBuilder: (context, index) {
                    var cuti = cutiController.modelCuti[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed('/cuti-detail', arguments: cuti);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .center, // ⬅️ agar Column ke atas
                            children: [
                              Icon(
                                cuti.status == 0
                                    ? Icons.hourglass_bottom
                                    : cuti.status == 1
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color:
                                    cuti.status == 0
                                        ? Colors.blue
                                        : cuti.status == 1
                                        ? Colors.green
                                        : Colors.red,
                                size: 30,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('Dari'),
                                        SizedBox(width: 5),
                                        Text(': ${cuti.tanggalAwal}'),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text('Sampai'),
                                        SizedBox(width: 5),
                                        Text(': ${cuti.tanggalAkhir}'),
                                      ],
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      cuti.keterangan.isNotEmpty
                                          ? cuti.keterangan
                                          : '-', // fallback kalau kosong
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
        onPressed: () {
          Get.toNamed('/cuti-create');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
