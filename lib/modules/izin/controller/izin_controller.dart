import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/izin/model/izin_model.dart';
import 'package:gopresent/services/izin_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:file_picker/file_picker.dart';

class IzinController extends GetxController {
  var isLoading = false.obs;
  final IzinService _izinService = IzinService();
  var listIzin = <ListIzin>[].obs;
  //tahun bulan tanggal
  var selectedFile = Rxn<File>();
  var tanggalAwal = Rxn<DateTime>();
  var tanggalAkhir = Rxn<DateTime>();
  var id = ''.obs;

  final tanggalAwalController = TextEditingController();
  final tanggalAkhirController = TextEditingController();
  final keteranganController = TextEditingController();
  final fileNameController = TextEditingController();

  String format(DateTime? date) {
    if (date == null) return '';
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Future<void> pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      selectedFile.value = File(result.files.single.path!);
      fileNameController.text = result.files.single.name; // << Tambahkan ini
    }
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

  Future<void> getIzin() async {
    isLoading.value = true;

    try {
      var result = await _izinService.GetIzin();

      if (result['status'] == true) {
        listIzin.value = ListIzin.fromJsonList(result['data']);
      } else if (result['success'] == 401) {
        Get.defaultDialog(
          title: 'Sesi Telah Habis',
          middleText: 'Login Kembali',
          textConfirm: 'OK',
          confirmTextColor: Get.theme.textTheme.bodyMedium?.color,
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

  Future<void> simpanIzin() async {
    final tanggalAwal = tanggalAwalController.text;
    final tanggalAkhir = tanggalAkhirController.text;
    final keterangan = keteranganController.text;
    final file = selectedFile!.value;
    isLoading.value = true;

    try {
      if (tanggalAwal.isEmpty || tanggalAkhir.isEmpty || keterangan.isEmpty) {
        Get.snackbar(
          'Gagal',
          'Semua field harus diisi',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
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

      var result = await _izinService.postIzin(
        tanggalAwal,
        tanggalAkhir,
        keterangan,
        file,
      );

      if (result['status'] == true) {
        Get.snackbar(
          'Berhasil',
          result['message'] ?? 'Data berhasil disimpan',
          snackPosition: SnackPosition.BOTTOM,
        );
        getIzin();
        Get.until((route) => Get.currentRoute == '/navbar');
        Get.toNamed('/izin');
        tanggalAwalController.clear();
        tanggalAkhirController.clear();
        keteranganController.clear();
        fileNameController.clear();
        selectedFile.value = null;
      } else if (result['success'] == 401) {
        Get.defaultDialog(
          title: 'Sesi Telah Habis',
          middleText: 'Login Kembali',
          textConfirm: 'OK',
          confirmTextColor: Get.theme.textTheme.bodyMedium?.color,
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

  Future<void> hapusIzin(id) async {
    isLoading.value = true;

    try {
      var result = await _izinService.hapusIzin(id);

      if (result['status'] == true) {
        Get.snackbar(
          'Berhasil',
          result['message'] ?? 'Data berhasil disimpan',
          snackPosition: SnackPosition.BOTTOM,
        );
        getIzin();
        Get.until((route) => Get.currentRoute == '/navbar');
        Get.toNamed('/izin');
        tanggalAwalController.clear();
        tanggalAkhirController.clear();
        keteranganController.clear();
        fileNameController.clear();
        selectedFile.value = null;
      } else if (result['success'] == 401) {
        Get.defaultDialog(
          title: 'Sesi Telah Habis',
          middleText: 'Login Kembali',
          textConfirm: 'OK',
          confirmTextColor: Get.theme.textTheme.bodyMedium?.color,
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

  void hapusFile() {
    selectedFile.value = null;
    fileNameController.clear();
  }

  @override
  void onInit() {
    getIzin();
    tanggalAwalController.text = format(tanggalAwal.value);
    tanggalAkhirController.text = format(tanggalAkhir.value);
    super.onInit();
  }
}
