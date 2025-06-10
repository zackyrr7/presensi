import 'package:get/get.dart';
import 'package:gopresent/modules/auth/controllers/reset_controller.dart';
import 'package:gopresent/modules/riwayat/model/riwayat_model.dart';
import 'package:gopresent/services/riwayat_service.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class RiwayatHitungController extends GetxController {
  var isLoading = false.obs;
  var hadir = 0.obs;
  var telat = 0.obs;
  var izin = 0.obs;
  var sakit = 0.obs;
  var listRiwayat = <ListRiwayat>[].obs;
  final ResetController resetController = Get.find<ResetController>();

  final RiwayatService _riwayatService = RiwayatService();

  Future<void> riwayatHitung() async {
    isLoading.value = true;

    try {
      var result = await _riwayatService.riwayatHitung();

      if (result['status'] == true) {
        final data = result['data'][0];
        hadir.value = data['hadir'] ?? 0;
        telat.value = data['telat'] ?? 0;
        izin.value = data['izin'] ?? 0;
        sakit.value = data['sakit'] ?? 0;
      } else if (result['succes'] == 401) {
        Get.defaultDialog(
          title: 'Sesi Telah Habisss',
          middleText: 'Login Kembali',
          textConfirm: 'Ok',
          confirmTextColor:
              Get.theme.textTheme.bodyMedium?.color ?? Colors.black,
          onConfirm: () {
            final box = GetStorage();
            box.remove('token');
            Get.offAndToNamed('/login');
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

  Future<void> riwayat() async {
    isLoading.value = true;

    try {
      var result = await _riwayatService.riwayat();

      if (result['status'] == true) {
        listRiwayat.value = ListRiwayat.fromJsonList(result['data']);
      } else if (result['success'] == 401) {
        Get.defaultDialog(
          title: 'Sesi Telah Habis',
          middleText: 'Login Kembali',
          textConfirm: 'OK',
          confirmTextColor:
              Get.theme.textTheme.bodyMedium?.color ?? Colors.black,
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

  @override
  void onInit() {
    // TODO: implement onInit
    riwayat();
    riwayatHitung();
    super.onInit();
  }
}
