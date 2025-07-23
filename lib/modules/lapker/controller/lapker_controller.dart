import 'package:get/get.dart';
import 'package:gopresent/modules/auth/controllers/reset_controller.dart';
import 'package:gopresent/modules/lapker/model/lapker_model.dart';
import 'package:gopresent/services/lapker_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LapkerController extends GetxController {
  final ResetController resetController = Get.find<ResetController>();
  var isLoading = false.obs;
  var tahun = DateTime.now().year.obs;
  final LapkerService lapkerService = LapkerService();
  var lapkerList = <TanggalModel>[].obs;
  var tanggalAwal = DateTime.now().obs;
  var tambahTanggalController = TextEditingController();
  var pilihanController = TextEditingController();
  var penggunaController = TextEditingController();
  var uraianController = TextEditingController();
  var idController = TextEditingController();

  var bulan = DateTime.now().month.obs;
  List<String> namaBulan = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  String format(DateTime? date) {
    if (date == null) return '';
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String get bulanIndo => namaBulan[bulan.value - 1];

  Future<void> getLapker() async {
    isLoading.value = true;
    print(bulan.value);
    try {
      var result = await lapkerService.getLapker(bulan.value, tahun.value);

      if (result['status'] == true) {
        lapkerList.value = TanggalModel.fromJsonList(result['data']);
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

  Future<void> pickDate2(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: tanggalAwal.value ?? DateTime.now(),

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
        tambahTanggalController.text = format(picked); // update text
      }
    }
  }

  Future<void> simpanLapker() async {
    isLoading.value = true;
    final tanggal = tambahTanggalController.text;
    final client = penggunaController.text;
    final uraian = uraianController.text;
    final statusAwal = pilihanController.text;

    try {
      if (tanggal.isEmpty ||
          client.isEmpty ||
          uraian.isEmpty ||
          statusAwal.isEmpty) {
        Get.snackbar(
          "Error",
          "Pastikan Semua data terisi",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
        return;
      }
      String status;
      if (statusAwal == "Dalam Pengerjaan") {
        status = "Og";
      } else if (statusAwal == 'Dalam Pengecekan') {
        status = "Oc";
      } else {
        status = "Ok";
      }

      var result = await lapkerService.tambahLapker(
        tanggal,
        client,
        uraian,
        status,
      );
      if (result['status'] == true) {
        Get.snackbar(
          'Berhasil',
          'Data berhasil disimpan',
          snackPosition: SnackPosition.BOTTOM,
        );
        getLapker();
        tambahTanggalController.clear();
        pilihanController.clear();
        penggunaController.clear();
        uraianController.clear();
        // resetFilter2();
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

  Future<void> Edit() async {
    isLoading.value = true;
    final tanggal = tambahTanggalController.text;
    final client = penggunaController.text;
    final uraian = uraianController.text;
    final statusAwal = pilihanController.text;
    final idLapker = idController.text;

    try {
      if (tanggal.isEmpty ||
          client.isEmpty ||
          uraian.isEmpty ||
          statusAwal.isEmpty ||
          idLapker.isEmpty) {
        Get.snackbar(
          "Error",
          "Pastikan Semua data terisi",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
        return;
      }
      String status;
      if (statusAwal == "Dalam Pengerjaan") {
        status = "Og";
      } else if (statusAwal == 'Dalam Pengecekan') {
        status = "Oc";
      } else {
        status = "Ok";
      }

      var result = await lapkerService.updateLapker(
        tanggal,
        client,
        uraian,
        status,
        idLapker,
      );
      if (result['status'] == true) {
        Get.snackbar(
          'Berhasil',
          'Data berhasil disimpan',
          snackPosition: SnackPosition.BOTTOM,
        );
        getLapker();
        Get.toNamed('/lapker');
        tambahTanggalController.clear();
        pilihanController.clear();
        penggunaController.clear();
        uraianController.clear();
        // resetFilter2();
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

  Future<void> hapusLapker() async {
    isLoading.value = true;
    final id = idController.text;

    try {
      var result = await lapkerService.hapus(id);

      if (result['status'] == true) {
        Get.snackbar(
          'Berhasil',
          'Data berhasil dihapus',
          snackPosition: SnackPosition.BOTTOM,
        );
        getLapker();
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
    // TODO: implement onInit
    getLapker();
    super.onInit();
  }
}
