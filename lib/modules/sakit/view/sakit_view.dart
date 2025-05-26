import 'package:flutter/material.dart';
import 'package:gopresent/modules/izin/controller/izin_controller.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/sakit/controller/sakit_controller.dart';

class SakitView extends StatelessWidget {
  SakitView({super.key});

  final SakitController sakitController = Get.find<SakitController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('SAKIT', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {
              sakitController.getSakit();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Obx(() {
        if (sakitController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: sakitController.sakitModel.length,
            itemBuilder: (context, index) {
              var sakit = sakitController.sakitModel[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed('/sakit-detail', arguments: sakit);
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
                          Icons.sick,
                          size: 40,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [Text(sakit.tanggal)]),

                              SizedBox(height: 6),
                              Text(
                                sakit.keterangan.isNotEmpty
                                    ? sakit.keterangan
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
          Get.toNamed('/sakit-create');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
