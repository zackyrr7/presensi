import 'package:flutter/material.dart';
import 'package:gopresent/modules/lapker/controller/lapker_controller.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/lapker/widget/add_lapker.dart';
import 'package:gopresent/modules/lapker/widget/edit_lapker.dart';

class LapkerDetailView extends StatelessWidget {
  LapkerDetailView({super.key});
  final LapkerController lapkerController = Get.find<LapkerController>();

  @override
  Widget build(BuildContext context) {
    final item = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          item.tanggalIndonesia,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Uraian Pekerjaan',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Aksi',
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
                          itemCount: item.detail.length,
                          itemBuilder: (context, index) {
                            final itemDetail = item.detail[index];
                            return ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 8,
                              ),
                              title: Text(itemDetail.uraian),
                              trailing: IconButton(
                                icon: Icon(Icons.note_alt),
                                iconSize: 28,
                                onPressed: () {
                                  String status;
                                  if (itemDetail == "Og") {
                                    status = "Dalam Pengerjaan";
                                  } else if (itemDetail == "Oc") {
                                    status = "Dalam Pengecekam";
                                  } else {
                                    status = "Selesai";
                                  }
                                  lapkerController.idController.text = itemDetail.id.toString();
                                  lapkerController.uraianController.text =
                                      itemDetail.uraian;
                                  lapkerController
                                      .tambahTanggalController
                                      .text = item.tanggal;
                                  lapkerController.penggunaController.text =
                                      itemDetail.client;
                                  lapkerController.pilihanController.text =
                                      status;
                                      Get.bottomSheet(EditLapker());
                                },
                              ),
                              onTap: () {
                                // Handle tap if needed
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
