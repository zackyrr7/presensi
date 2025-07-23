import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:gopresent/modules/amal/controller/amal_controller.dart';

class AmalView extends StatelessWidget {
  AmalView({super.key});
  final AmalController amalController = Get.find<AmalController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Amal Yaumi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              amalController.getAmal();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            amalController.cekModified();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(),
              color: Theme.of(context).colorScheme.secondary,
            ),
            width: Get.width * 0.9,
            child: Column(
              children: [
                SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Aktivitas Amal yaumi',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      amalController.formattedTanggal,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                SizedBox(height: 8),
                Expanded(
                  child: Obx(() {
                    if (amalController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        itemCount: amalController.amalModel.length,
                        itemBuilder: (context, index) {
                          final amal = amalController.amalModel[index];
                          return Column(
                            children: [
                              ListTile(
                                leading: Obx(
                                  () => Switch(
                                    value: amal.isDone.value == 1,
                                    onChanged: (bool newValue) {
                                      final newStatus = newValue ? 1 : 0;
                                      if (amal.isDone.value != newStatus) {
                                        amal.isDone.value = newStatus;
                                        amal.isModified = true;
                                      }
                                    },
                                  ),
                                ),

                                title: Text(
                                  amal.nama,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Container(
                                height: 1,
                                color: Theme.of(context).colorScheme.onTertiary,
                                width: Get.width * 0.8,
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
        onPressed: () {
          amalController.submitOnlyModifiedItems();
        },
        label: Text('Simpan', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
