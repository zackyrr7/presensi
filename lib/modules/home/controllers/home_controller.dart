import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/services/home_service.dart';
import 'package:gopresent/services/login_service.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  final HomeService _homeToday = HomeService();
  var nama = ''.obs;
  var perusahaan = ''.obs;
  var tanggal = ''.obs;
  var jamMasuk = ''.obs;
  var jamPulang = ''.obs;
  var statusMasuk = ''.obs;
  var statusPulang = ''.obs;

  Future<void> homeToday() async {
    isLoading.value = true;

    try {
      var result = await _homeToday.homeToday();

      if (result['status'] == true) {
        final data = result['data'];
        nama.value = data['nmpegawai'] ?? '';
        perusahaan.value = data['perusahaan'] ?? '';
        tanggal.value = data['tanggal'] ?? '';
        jamMasuk.value = data['jammasuk'] ?? '';
        jamPulang.value = data['jampulang'] ?? '';

        

        if (jamMasuk.value == '00:00:00') {
          statusMasuk.value = 'Belum Absen';
        } else{
          statusMasuk.value = 'Sudah Absen';
        }
        if (jamPulang.value == '00:00:00') {
          statusPulang.value = 'Belum Absen';
        } else{
          statusPulang.value = 'Sudah Absen';
        }




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

  @override
  void onInit() {
    // TODO: implement onInit
    homeToday();
    super.onInit();
  }
}
