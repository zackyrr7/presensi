import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/lembur/controller/lembur_controller.dart';

class BottomSheetUbahStatus extends StatelessWidget {
  BottomSheetUbahStatus({super.key, required this.index, this.detail});

  final int index;
  final dynamic detail;

 
  final LemburController lemburController = Get.find<LemburController>();

  @override
  Widget build(BuildContext context) {
    // Isi controller dengan data lama
    lemburController.keteranganController.text = detail?.uraianPekerjaan ?? '';
    lemburController.selectedValue.value = detail.status ?? 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // biar bottomsheet tinggi secukupnya
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 20),
            const Text(
              'Uraian Pekerjaan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: lemburController.keteranganController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Masukkan uraian pekerjaan',
                  labelStyle: TextStyle(color: Colors.black38),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            const Text(
              'Status Pekerjaan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Obx(
              () => DropdownButtonFormField<int>(
                value: lemburController.selectedValue.value,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: 0, child: Text('Belum Selesai')),
                  DropdownMenuItem(value: 1, child: Text('Dalam Pengerjaan')),
                  DropdownMenuItem(value: 2, child: Text('Dalam Pengecekan')),
                  DropdownMenuItem(value: 3, child: Text('Selesai')),
                ],
                onChanged:
                    (val) => lemburController.selectedValue.value = val ?? 0,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      lemburController.updateLembur(detail?.id);
                    },
                    child: const Text(
                      'Simpan',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      lemburController.hapusLembur(detail?.id);
                    },
                    child: Text('Hapus', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
