import 'package:flutter/material.dart';
import 'package:gopresent/modules/home/controllers/home_controller.dart';
import 'package:gopresent/modules/lembur/controller/lembur_controller.dart';
import 'package:get/get.dart';

class CreateBottomSheetLembur extends StatelessWidget {
  CreateBottomSheetLembur({super.key});
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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Tombol X di kiri atas
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.cancel, size: 30),
                  ),
                ),
                // Judul di tengah
                const Center(
                  child: Text(
                    "Edit Data Lembur",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: Get.width * 0.95,
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
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
                  border: OutlineInputBorder(),
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
                  border: OutlineInputBorder(),
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
                  border: OutlineInputBorder(),
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
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  labelText: 'Status Pekerjaan',
                  labelStyle: TextStyle(color: Colors.black38),
                ),
                onTap: () {
                  showPilihanDialog();
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                lemburController.postLembur();
              },
              child: Text('Simpan'),
            ),
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
