import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:gopresent/modules/home/controllers/home_controller.dart';
import 'package:gopresent/modules/izin/controller/izin_controller.dart';
import 'package:gopresent/modules/sakit/controller/sakit_controller.dart';
import 'package:open_file/open_file.dart';

class CreateSakitView extends StatelessWidget {
  CreateSakitView({super.key});
  final namaController = Get.find<HomeController>();
  final sakitController = Get.find<SakitController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Pengajuan Sakit',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Get.height * 0.45,
              width: Get.width,
              child: Image.asset('assets/image/sick.png', fit: BoxFit.cover),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  namaController.nama.value,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: Get.width * 0.95,
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                readOnly: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  labelText: 'Tanggal',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () => sakitController.pickDate(context, true),
                controller: sakitController.tanggalAwalController,
              ),
            ),
            SizedBox(height: 20),
            
            SizedBox(
              width: Get.width * 0.95,
              child: TextField(
                maxLines: 5,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  labelText: 'Keterangan',
                  hintText: 'Masukkan Keterangan',
                ),
                controller: sakitController.keteranganController,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: Get.width * 0.95,
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                readOnly: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  labelText: 'File PDF (Opsional)',
                  suffixIcon: Row(
                    mainAxisSize:
                        MainAxisSize.min, // supaya Row tidak memenuhi lebar
                    children: [
                      IconButton(
                        icon: Icon(Icons.attach_file),
                        onPressed: () async {
                          await sakitController.pickPdf();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () async {
                          final file = sakitController.selectedFile.value;
                          if (file != null) {
                            await OpenFile.open(file.path);
                          } else {
                            Get.snackbar(
                              'File Kosong',
                              'Belum ada file yang dipilih.',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          sakitController.hapusFile();
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
                controller: sakitController.fileNameController,
                onTap: () {},
              ),
            ),

            SizedBox(height: 200),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 150,
        height: 50,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: () {
            sakitController.simpanSakit();
          },
          child: Obx(() {
            if (sakitController.isLoading.value) {
              return CircularProgressIndicator();
            } else {
              return Text('Simpan', style: TextStyle(fontSize: 15));
            }
          }),
        ),
      ),
    );
  }
}
