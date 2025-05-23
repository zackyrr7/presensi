import 'package:flutter/material.dart';
import 'package:gopresent/modules/izin/controller/izin_controller.dart';
import 'package:get/get.dart';

class IzinView extends StatelessWidget {
  IzinView({super.key});

  final IzinController izinController = Get.find<IzinController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'IZIN PEGAWAI',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              izinController.listIzin();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Obx(() {
        if (izinController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: izinController.listIzin.length,
            itemBuilder: (context, index) {
              var izin = izinController.listIzin[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed('/izin-detail', arguments: izin);
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
                          CrossAxisAlignment.center, // ⬅️ agar Column ke atas
                      children: [
                        Icon(
                          izin.status == 0
                              ? Icons.hourglass_bottom
                              : izin.status == 1
                              ? Icons.check_circle
                              : Icons.cancel,
                          color:
                              izin.status == 0
                                  ? Colors.blue
                                  : izin.status == 1
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
                                  Text(': ${izin.tanggalAwal}'),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Text('Sampai'),
                                  SizedBox(width: 5),
                                  Text(': ${izin.tanggalAkhir}'),
                                ],
                              ),
                              SizedBox(height: 6),
                              Text(
                                izin.keterangan.isNotEmpty
                                    ? izin.keterangan
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
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
        onPressed: () {
          Get.toNamed('/izin-create');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
