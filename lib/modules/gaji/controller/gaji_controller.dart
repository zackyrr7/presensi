import 'dart:io';

import 'package:get/get.dart';
import 'package:gopresent/modules/auth/controllers/reset_controller.dart';
import 'package:gopresent/services/gaji_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class GajiController extends GetxController {
  var isLoading = false.obs;
  var bulanAwal = DateTime.now().month.obs;
  var tahunAwal = DateTime.now().year.obs;
  var file = Rx<File?>(null);
  var is_downloadAwal = 0.obs;
  final GajiService _gajiService = GajiService();
  final ResetController resetController = Get.find<ResetController>();

  Future<void> getGaji() async {
    isLoading.value = true;
    final bulan = bulanAwal.value;
    final tahun = tahunAwal.value;
    final is_download = is_downloadAwal.value;
    

    try {
      final result = await _gajiService.downloadPdf(bulan, tahun, is_download);
      if (result['status'] == true) {
        file.value = result['file'];
      } else if (result['success'] == 401) {
        Get.defaultDialog(
          title: 'Sesi Telah Habis',
          middleText: 'Login Kembali',
          textConfirm: 'OK',
          confirmTextColor: Get.theme.textTheme.bodyMedium?.color,
          onConfirm: () {
            resetController.deleteSession();
          },
        );
      } else {
        Get.snackbar(
          'Gagal',
          result['message'] ?? 'Terjadi kesalahan',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> downloadPdfToDevice() async {
    final file = this.file.value;

    if (file == null || !file.existsSync()) {
      Get.snackbar("Gagal", "File PDF tidak ditemukan");
      return;
    }

    try {
      final downloadsDir =
          await getApplicationDocumentsDirectory(); // iOS-compatible
      final savePath = '${downloadsDir.path}/slip-gaji-simpan.pdf';
      final savedFile = await file.copy(savePath);

      Get.snackbar("Berhasil", "PDF berhasil disimpan ke:\n$savePath");
      OpenFile.open(savedFile.path);
    } catch (e) {
      Get.snackbar("Gagal", "Gagal menyimpan PDF: $e");
    }
  }

  @override
  void onInit() {
    getGaji();
    super.onInit();
  }
}
