import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/absen/controller/absen_controller.dart';
import 'package:gopresent/modules/home/controllers/home_controller.dart';

class AbsenCreateView extends StatelessWidget {
  AbsenCreateView({super.key});
  final AbsenController absenController = Get.find<AbsenController>();
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          absenController.type.value == 'in' ? 'Absen Masuk' : 'Absen Pulang',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: Get.height * 0.45,
            width: Get.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Obx(() {
              if (absenController.imageFile.value != null) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.file(
                    absenController.imageFile.value!,
                    fit: BoxFit.cover,
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    'Belum Ada Foto',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                );
              }
            }),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'latitude:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Text(
                    absenController.latitude.value.toString(),
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'longitude:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Text(
                    absenController.longitude.value.toString(),
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: Get.width * 0.6,
            child: ElevatedButton(
              onPressed: () {
                absenController.takePhoto();
              },
              child: Text(
                absenController.imageFile.value != null
                    ? 'Ubah Foto'
                    : 'Ambil Foto',
              ),
            ),
          ),
          SizedBox(
            width: Get.width * 0.6,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                if (absenController.imageFile.value == null) {
                  Get.snackbar('Error', 'Silahkan ambil foto terlebih dahulu');
                  return;
                } else {
                  absenController.simpanAbsen();
                }
              },
              child: Text('Kirim Absen'),
            ),
          ),
        ],
      ),
      
    );
  }
}
