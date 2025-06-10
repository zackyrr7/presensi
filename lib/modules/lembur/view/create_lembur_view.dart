import 'package:flutter/material.dart';
import 'package:gopresent/modules/home/controllers/home_controller.dart';
import 'package:gopresent/modules/lembur/controller/lembur_controller.dart';
import 'package:get/get.dart';

class CreateLemburView extends StatelessWidget {
  CreateLemburView({super.key});
  final LemburController lemburController = Get.find<LemburController>();
  final HomeController namaController = Get.find<HomeController>();

  final List<String> options = [
    "Dalam Pengerjaan",
    "Dalam Pengecekan",
    "Selesai",
    "Belum Selesai",
  ];

  Future<void> showPilihanDialog() async {
    final result = await Get.dialog<String>(
      AlertDialog(
        title: const Text("Pilih Status Pekerjaan"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children:
              options.map((item) {
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    Get.back(result: item); // Kembalikan nilai string item
                  },
                );
              }).toList(),
        ),
      ),
    );

    if (result != null) {
      lemburController.pilihanController.text = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Tambah Lembur',
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
              child: Image.asset('assets/image/lembur.jpg', fit: BoxFit.cover),
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
                  labelStyle: TextStyle(color: Colors.black38),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () => lemburController.pickDate(context),
                controller: lemburController.tanggalController,
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
                  labelText: 'Mulai',
                  labelStyle: TextStyle(color: Colors.black38),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () => lemburController.pickDateTimeMulai(context),
                controller: lemburController.mulaiController,
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
                  labelText: 'Selesai',
                  labelStyle: TextStyle(color: Colors.black38),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () => lemburController.pickDateTimeSelesai(context),
                controller: lemburController.selesaiController,
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
                  labelText: 'Uraian Pekerjaan',
                  labelStyle: TextStyle(color: Colors.black38),
                  hintText: 'Masukkan Uraian Pekerjaan',
                ),
                controller: lemburController.keteranganController,
              ),
            ),

            // SizedBox(height: 20),
            SizedBox(height: 20),
            SizedBox(
              width: Get.width * 0.95,
              child: TextFormField(
                controller: lemburController.pilihanController,
                style: TextStyle(color: Colors.black),
                readOnly: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  labelText: 'Status Pekerjaan',
                  labelStyle: TextStyle(color: Colors.black38),
                ),
                onTap: () {
                  showPilihanDialog();
                },
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
          backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: () {
            lemburController.postLembur();
          },
          child: Obx(() {
            if (lemburController.isLoading.value) {
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
