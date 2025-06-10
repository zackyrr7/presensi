import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gopresent/modules/auth/controllers/reset_controller.dart';
import 'package:gopresent/modules/cuti/model/cuti_model.dart';
import 'package:gopresent/services/cuti_service.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/izin/model/izin_model.dart';
import 'package:gopresent/services/izin_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:file_picker/file_picker.dart';

class CutiController extends GetxController {
  var isLoading = false.obs;
  final CutiService _cutiService = CutiService();
  var modelCuti = <ModelCuti>[].obs;
  //tahun bulan tanggal
  var selectedFile = Rxn<File>();
  var tanggalAwal = Rxn<DateTime>();
  var tanggalAkhir = Rxn<DateTime>();
  var id = ''.obs;
  var jumlah = ''.obs;
  var diambil = ''.obs;
  var sisa = ''.obs;
  var jenis2 = ''.obs;

  final tanggalAwalController = TextEditingController();
  final tanggalAkhirController = TextEditingController();
  final keteranganController = TextEditingController();
  final pilihanController = TextEditingController();
  final ResetController resetController = Get.find<ResetController>();

  String format(DateTime? date) {
    if (date == null) return '';
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Future<void> pickDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          isStart
              ? (tanggalAwal.value ?? DateTime.now())
              : (tanggalAkhir.value ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale("id", "ID"),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data:
              Theme.of(context).brightness == Brightness.dark
                  ? ThemeData.dark().copyWith(
                    colorScheme: ColorScheme.dark(
                      primary: Colors.blue, // Warna "OK"
                      onPrimary: Colors.white, // Warna teks "OK"
                      surface: Colors.grey[900]!,
                      onSurface: Colors.white,
                    ),
                    dialogBackgroundColor: Colors.grey[850],
                  )
                  : ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      surface: Colors.white,
                      onSurface: Colors.black,
                    ),
                  ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (isStart) {
        tanggalAwal.value = picked;
        tanggalAwalController.text = format(picked); // update text
      } else {
        tanggalAkhir.value = picked;
        tanggalAkhirController.text = format(picked); // update text
      }
    }
  }

  Future<void> getCuti() async {
    isLoading.value = true;

    try {
      var result = await _cutiService.GetCuti();

      if (result['status'] == true) {
        modelCuti.value = ModelCuti.fromJsonList(result['data']);
        jumlah.value = result['jatah'].toString();
        diambil.value = result['ambil'].toString();
        sisa.value = result['sisa'].toString();
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

  Future<void> simpanCuti() async {
    final tanggalAwal = tanggalAwalController.text;
    final tanggalAkhir = tanggalAkhirController.text;
    final keterangan = keteranganController.text;
    final jenis = pilihanController.text;
    isLoading.value = true;

    try {
      if (tanggalAwal.isEmpty ||
          tanggalAkhir.isEmpty ||
          keterangan.isEmpty ||
          jenis.isEmpty) {
        Get.snackbar(
          'Gagal',
          'Semua field harus diisi',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      if (jenis == 'Tahunan') {
        jenis2.value = 'tahunan';
      } else if (jenis == 'Melahirkan') {
        jenis2.value = 'melahirkan';
      } else if (jenis == 'Menikah') {
        jenis2.value = 'menikah';
      } else {
        jenis2.value = 'luartanggungan';
      }

      final DateTime? awal = DateTime.tryParse(tanggalAwal);
      final DateTime? akhir = DateTime.tryParse(tanggalAkhir);

      if (awal!.isAfter(akhir!)) {
        Get.snackbar(
          'Gagal',
          'Tanggal Awal tidak boleh lebih besar dari Tanggal Akhir',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      var result = await _cutiService.postCuti(
        tanggalAwal,
        tanggalAkhir,
        keterangan,
        jenis2.value,
      );

      if (result['status'] == true) {
        Get.snackbar(
          'Berhasil',
          result['message'] ?? 'Data berhasil disimpan',
          snackPosition: SnackPosition.BOTTOM,
        );
        getCuti();
        Get.until((route) => Get.currentRoute == '/navbar');
        Get.toNamed('/cuti');
        tanggalAwalController.clear();
        tanggalAkhirController.clear();
        keteranganController.clear();
        pilihanController.clear();
        selectedFile.value = null;
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

  Future<void> hapusCuti(id) async {
    isLoading.value = true;

    try {
      var result = await _cutiService.hapusCuti(id);

      if (result['status'] == true) {
        Get.snackbar(
          'Berhasil',
          result['message'] ?? 'Data berhasil dihapus',
          snackPosition: SnackPosition.BOTTOM,
        );
        getCuti();
        Get.until((route) => Get.currentRoute == '/navbar');
        Get.toNamed('/cuti');
        tanggalAwalController.clear();
        tanggalAkhirController.clear();
        keteranganController.clear();
        // fileNameController.clear();
        selectedFile.value = null;
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

  @override
  void onInit() {
    getCuti();
    tanggalAwalController.text = format(tanggalAwal.value);
    tanggalAkhirController.text = format(tanggalAkhir.value);
    super.onInit();
  }
}
