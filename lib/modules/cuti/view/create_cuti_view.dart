import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:gopresent/modules/cuti/controller/cuti_controller.dart';
import 'package:gopresent/modules/home/controllers/home_controller.dart';
import 'package:gopresent/modules/izin/controller/izin_controller.dart';
import 'package:open_file/open_file.dart';

class CreateCutiView extends StatelessWidget {
  CreateCutiView({super.key});
  final namaController = Get.find<HomeController>();
  final CutiController cutiController = Get.find<CutiController>();

  final List<String> options = [
    "Tahunan",
    "Melahirkan",
    "Menikah",
    "Di Luar Tanggungan",
  ];

  Future<void> showPilihanDialog() async {
    final result = await Get.defaultDialog<String>(
      title: "Pilih Jenis Cuti",
      content: Column(
        children:
            options.map((item) {
              return ListTile(
                title: Text(item),
                onTap: () {
                  Get.back(result: item); // Kembalikan nilai
                },
              );
            }).toList(),
      ),
      radius: 10,
    );

    if (result != null) {
      cutiController.pilihanController.text = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Pengajuan Cuti',
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
              child: Image.asset('assets/image/cuti.png', fit: BoxFit.cover),
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
                controller: cutiController.pilihanController,
                style: TextStyle(color: Colors.black),
                readOnly: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  labelText: 'Jenis Cuti',
                ),
                onTap: () {
                  showPilihanDialog();
                },
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
                  labelText: 'Tanggal Awal',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () => cutiController.pickDate(context, true),
                controller: cutiController.tanggalAwalController,
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
                  labelText: 'Tanggal Akhir',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () => cutiController.pickDate(context, false),
                controller: cutiController.tanggalAkhirController,
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
                controller: cutiController.keteranganController,
              ),
            ),
            SizedBox(height: 20),

            SizedBox(height: 200),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 150,
        height: 50,
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: () {
            cutiController.simpanCuti();
          },
          child: Obx(() {
            if (cutiController.isLoading.value) {
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
