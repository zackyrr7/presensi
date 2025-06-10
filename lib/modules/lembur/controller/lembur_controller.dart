import 'dart:convert';

import 'package:get/get.dart';
import 'package:gopresent/modules/auth/controllers/reset_controller.dart';
import 'package:gopresent/modules/lembur/model/lembur_model.dart';
import 'package:gopresent/services/lembur_service.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class LemburController extends GetxController {
  final ResetController resetController = Get.find<ResetController>();
  var isLoading = false.obs;
  final LemburService _lemburService = LemburService();

  var lemburList = <LemburItem>[].obs;
  var bulan = ''.obs;
  var selectedValue = 0.obs;




  Future<void> getLembur() async {
    isLoading.value = true;

    try {
      var result = await _lemburService.getLembur(bulan.value);
      if (result['status'] == true) {
        // Pastikan result['data'] sudah berupa JSON string atau Map
        // Jika data sudah Map/List, jangan decode ulang
        if (result['data'] is List) {
          lemburList.value = LemburItem.fromJsonList(result['data']);
        } else if (result['data'] is String) {
          lemburList.value = LemburItem.fromJsonList(
            jsonDecode(result['data']),
          );
        } else {
          Get.snackbar(
            'Gagal',
            result['message'] ?? 'Terjadi kesalahan',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
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

   Map<String, dynamic> getStatusInfo(int? status) {
    switch (status) {
      case 1:
        return {
          'label': 'Dalam Pengerjaan',
          'color': Colors.orange,
        };
      case 2:
        return {
          'label': 'Dalam Pengecekan',
          'color': Colors.blue,
        };
      case 3:
        return {
          'label': 'Selesai',
          'color': Colors.green,
        };
      default:
        return {
          'label': 'Belum Selesai',
          'color': Colors.grey,
        };
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getLembur();
    super.onInit();
  }
}
