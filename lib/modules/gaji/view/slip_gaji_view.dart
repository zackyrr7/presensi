import 'package:flutter/material.dart';
import 'package:gopresent/modules/gaji/controller/gaji_controller.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:month_year_picker/month_year_picker.dart';

class SlipGajiView extends StatelessWidget {
  SlipGajiView({super.key});
  final GajiController gajiController = Get.find<GajiController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Slip Gaji',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final pickedDate = await showMonthYearPicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                gajiController.bulanAwal.value = pickedDate.month;
                gajiController.tahunAwal.value = pickedDate.year;
              
                gajiController.getGaji();
              }
            },

            icon: const Icon(Icons.date_range),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (gajiController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final file = gajiController.file.value;

          if (file == null || !file.existsSync()) {
            return const Center(child: Text("PDF tidak tersedia"));
          }

          return SfPdfViewer.file(
            file,
            canShowScrollHead: true,
            canShowScrollStatus: true,
            enableTextSelection: true,
            pageLayoutMode: PdfPageLayoutMode.continuous, // ini diganti
            maxZoomLevel: 1.5, // opsional, coba-coba
            onDocumentLoadFailed: (details) {
              Get.snackbar("Gagal Memuat PDF", details.description);
            },
          );
        }),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
        label: const Text(
          'Download',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          gajiController.downloadPdfToDevice();
        },
      ),
    );
  }
}
