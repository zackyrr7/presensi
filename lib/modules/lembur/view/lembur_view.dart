import 'package:flutter/material.dart';
import 'package:gopresent/modules/lembur/controller/lembur_controller.dart';
import 'package:get/get.dart';

class LemburView extends StatelessWidget {
  LemburView({super.key});
  final LemburController lemburController = Get.find<LemburController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lembur Pegawai',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
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
                          lemburController.bulan.value = (index + 1);
                          Get.back();
                          lemburController.getLembur();
                        },
                      );
                    },
                  ),
                ),
                cancel: Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(onPressed: () {
                    Get.back();
                  }, child: Text('Batal')),
                ),
              );
            },
            icon: Icon(Icons.filter_list),
          ),
        ],
        centerTitle: true,
      ),
      body: Obx(() {
        if (lemburController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: lemburController.lemburList.length,
            itemBuilder: (context, index) {
              final item = lemburController.lemburList[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lemburController.lemburList[index].tanggal,
                          style: TextStyle(fontSize: 16),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            Get.toNamed('/lembur-detail', arguments: item);
                          },
                          child: Text('Detail'),
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
        onPressed: () {
          Get.toNamed('lembur-create');
        },
        backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
        child: Icon(Icons.add),
      ),
    );
  }
}
