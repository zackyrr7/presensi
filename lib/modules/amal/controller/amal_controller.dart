import 'package:get/get.dart';
import 'package:gopresent/modules/amal/model/amal_model.dart';
import 'package:gopresent/modules/auth/controllers/reset_controller.dart';
import 'package:gopresent/services/amal_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AmalController extends GetxController {
  var isLoading = false.obs;
  final AmalService _amalService = AmalService();
  var amalModel = <ListAktivitas>[].obs;
  final ResetController resetController = Get.find<ResetController>();
  final DateTime tanggal = DateTime.now();
  String get formattedTanggal =>
      DateFormat("d MMMM yyyy", "id_ID").format(tanggal);

  Future<void> getAmal() async {
    isLoading.value = true;

    try {
      var result = await _amalService.GetAmal();

      if (result['status'] == true) {
        amalModel.value = ListAktivitas.fromJsonList(result['data']);
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

  void toggleIsDoneById(int id, bool newValue) {
    final amal = amalModel.firstWhereOrNull((e) => e.id == id);
    if (amal != null) {
      final newInt = newValue ? 1 : 0;
      if (amal.isDone != newInt) {
        amal.isDone.value = newInt;
        amal.isModified = true;
      }
    }
  }

  Future<void> cekModified() async {
    final modifiedItems = amalModel.where((e) => e.isModified).toList();

    if (modifiedItems.isNotEmpty) {
      Get.snackbar(
        'Info',
        'Simpan Perubahan lebih dahulu',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    } else {
      Get.back();
    }
  }

  Future<void> submitOnlyModifiedItems() async {
    final modifiedItems = amalModel.where((e) => e.isModified).toList();

    if (modifiedItems.isEmpty) {
      Get.snackbar(
        'Info',
        'Tidak ada perubahan yang disimpan.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;

    for (final item in modifiedItems) {
      try {
        final result = await _amalService.updateIsdone(
          item.id,
          item.isDone.value,
        );

        if (result['status'] == true) {
          // Reset modified flag setelah berhasil
          item.isModified = false;

          // Jika data baru dikembalikan
          if (result['data'] != null) {
            amalModel.value = ListAktivitas.fromJsonList(result['data']);
          }
        } else if (result['success'] == 401) {
          Get.defaultDialog(
            title: 'Sesi Telah Habis',
            middleText: 'Silakan login kembali.',
            textConfirm: 'OK',
            confirmTextColor:
                Get.theme.textTheme.bodyMedium?.color ?? Colors.black,
            onConfirm: () {
              resetController.deleteSession();
            },
          );
          break; // Keluar loop karena user harus login ulang
        } else {
          Get.snackbar(
            'Gagal',
            result['message'] ?? 'Terjadi kesalahan saat menyimpan data.',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'Terjadi error saat menyimpan ID ${item.id}: $e',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }

    isLoading.value = false;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getAmal();
    super.onInit();
  }
}
