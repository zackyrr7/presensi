import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/absen/controller/absen_controller.dart';
import 'package:gopresent/modules/home/controllers/home_controller.dart';

class AbsenView extends StatelessWidget {
  AbsenView({super.key});
  final HomeController namaController = Get.find<HomeController>();
  final AbsenController absenController = Get.find<AbsenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ABSENSI', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.35,
              width: Get.width,
              child: Image.asset('assets/image/selfie.png', fit: BoxFit.contain),
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
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Perhatian :',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.onPrimaryFixed,
                    child: Text('1'),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Silahkan melakukan absen menggunakan smartphone anda',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.onPrimaryFixed,
                    child: Text('2'),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Gunakan Kamera Depan anda utnuk melalukan absensi',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.onPrimaryFixed,
                    child: Text('3'),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Pastikan GPS anda sudah akrif',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 100),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.onPrimaryFixed,
                    child: Text('4'),
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'Izinkan Aplikasi ini untuk mengakses lokasi anda',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() {
              final now = absenController.currentTime.value;
              final formattedTime =
                  "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
              return Text(
                formattedTime,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              );
            }),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: SizedBox(
                width: 140,
                height: 50,
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    // aksi absen
                    absenController.getCurrentLocation();
                    absenController.cekInOut();
                  },
                  child: Obx(() {
                    if (absenController.isLoading.value) {
                      return CircularProgressIndicator(color: Colors.white);
                    } else {
                      return Text('Absen', style: TextStyle(fontSize: 15));
                    }
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
