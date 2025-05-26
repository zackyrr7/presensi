import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gopresent/modules/sakit/controller/sakit_controller.dart';
import 'package:gopresent/modules/sakit/model/sakit_model.dart';

class DetailSakitView extends StatelessWidget {
  DetailSakitView({super.key});
  final sakitController = Get.find<SakitController>();
  @override
  Widget build(BuildContext context) {
    final ModelSakit modelSakit = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          modelSakit.tanggal,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: Get.width * 0.85,
          height: Get.height * 0.80,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Container(
                width: Get.width * 0.75,
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
                      'Keterangan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(modelSakit.keterangan, textAlign: TextAlign.justify),
                    SizedBox(height: 8),
                  ],
                ),
              ),
              // SizedBox(height: 15),
              // Container(
              //   width: Get.width * 0.75,
              //   decoration: BoxDecoration(
              //     border: Border(
              //       bottom: BorderSide(
              //         color: Theme.of(context).colorScheme.onSurface,
              //       ),
              //     ),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         'Tanggal',
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 16,
              //         ),
              //       ),
              //       SizedBox(height: 8),
              //       Text('${listIzin.tanggalAwal} - ${listIzin.tanggalAkhir}'),
              //       SizedBox(height: 8),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 15),
              // Container(
              //   width: Get.width * 0.75,
              //   decoration: BoxDecoration(
              //     border: Border(
              //       bottom: BorderSide(
              //         color: Theme.of(context).colorScheme.onSurface,
              //       ),
              //     ),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         'Keperluan',
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 16,
              //         ),
              //       ),
              //       SizedBox(height: 8),
              //       Text(listIzin.keterangan, textAlign: TextAlign.justify),
              //       SizedBox(height: 8),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 15),
              // Container(
              //   width: Get.width * 0.75,
              //   decoration: BoxDecoration(
              //     border: Border(
              //       bottom: BorderSide(
              //         color: Theme.of(context).colorScheme.onSurface,
              //       ),
              //     ),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         'Status',
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 16,
              //         ),
              //       ),
              //       SizedBox(height: 8),
              //       Text(
              //         listIzin.status == 0
              //             ? 'Menunggu Persetujuan'
              //             : listIzin.status == 1
              //             ? 'Di Setujui'
              //             : 'Tidak Disetujui',
              //         style: TextStyle(
              //           fontSize: 18,
              //           color:
              //               listIzin.status == 0
              //                   ? Colors.amber
              //                   : listIzin.status == 1
              //                   ? Colors.green
              //                   : Colors.red,
              //         ),
              //       ),
              //       SizedBox(height: 8),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 20),
              // listIzin.status == 0
              //     ? Align(
              //       alignment: Alignment.centerRight,
              //       child: Padding(
              //         padding: const EdgeInsets.only(right: 20.0),
              //         child: Container(
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(10),
              //             color: Colors.red,
              //           ),
              //           width: Get.width * 0.1,
              //           height: Get.width * 0.1,
              //           child: GestureDetector(
              //             onTap: () {
              //               izinController.hapusIzin(listIzin.id);
              //             },
              //             child: Obx(() {
              //               if (izinController.isLoading.value) {
              //                 return Center(child: CircularProgressIndicator());
              //               } else {
              //                 return Icon(Icons.delete, color: Colors.white, size: 30);
              //               }
              //             }),
              //           ),
              //         ),
              //       ),
              //     )
              //     : SizedBox.shrink(), // ⬅️ ini untuk status selain 0
            ],
          ),
        ),
      ),
    );
  }
}
