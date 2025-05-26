import 'package:get/get.dart';
import 'package:gopresent/modules/auth/controllers/reset_controller.dart';
import 'package:gopresent/modules/home/model/notification_model.dart';
import 'package:gopresent/modules/riwayat/model/riwayat_model.dart';
import 'package:gopresent/services/notification_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class NotificationController extends GetxController {
  var isLoading = false.obs;
  final NotificationService _notificationService = NotificationService();
  var listnotification = <NotificationModel>[].obs;
  final ResetController resetController = Get.find<ResetController>();

  Future<void> notification() async {
    isLoading.value = true;

    try {
      var result = await _notificationService.GetNotification();

      if (result['status'] == true) {
        listnotification.value = NotificationModel.fromJsonList(result['data']);
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
    notification();
    // TODO: implement onInit
    super.onInit();
  }
}
