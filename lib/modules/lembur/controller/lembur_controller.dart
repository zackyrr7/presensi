import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
  var bulan = 0.obs;
  var selectedValue = 0.obs;
  var tanggal = Rxn<DateTime>();
  var mulai = Rxn<DateTime>();
  var selesai = Rxn<DateTime>();

  final tanggalController = TextEditingController();
  final mulaiController = TextEditingController();
  final selesaiController = TextEditingController();
  final keteranganController = TextEditingController();
  final pilihanController = TextEditingController();

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: tanggal.value ?? DateTime.now(),
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
      tanggal.value = picked;
      tanggalController.text =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    }
  }

  Future<void> pickDateTimeMulai(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
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

    if (pickedDate != null) {
      DateTime tempPickedTime = DateTime.now();

      await showModalBottomSheet(
        context: context,
        isDismissible: true,
        builder: (BuildContext builderContext) {
          return SizedBox(
            height: 300,
            child: Column(
              children: [
                // Bar atas dengan tombol OK
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(builderContext).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: const Text(
                        "OK",
                        style: TextStyle(
                          color: CupertinoColors.activeBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                // Picker waktu
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: tempPickedTime,
                    use24hFormat: true,
                    onDateTimeChanged: (DateTime newTime) {
                      tempPickedTime = newTime;
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );

      // Gabungkan tanggal dan waktu
      final DateTime combined = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        tempPickedTime.hour,
        tempPickedTime.minute,
        tempPickedTime.second,
      );

      mulai.value = combined;

      // Format jadi yyyy-MM-dd HH:mm (tanpa detik)
      final String formatted =
          '${combined.year.toString().padLeft(4, '0')}-'
          '${combined.month.toString().padLeft(2, '0')}-'
          '${combined.day.toString().padLeft(2, '0')} '
          '${combined.hour.toString().padLeft(2, '0')}:'
          '${combined.minute.toString().padLeft(2, '0')}:'
          '${combined.second.toString().padLeft(2, '0')}';

      mulaiController.text = formatted;
    }
  }

  Future<void> pickDateTimeSelesai(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
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

    if (pickedDate != null) {
      DateTime tempPickedTime = DateTime.now();

      await showModalBottomSheet(
        context: context,
        isDismissible: true,
        builder: (BuildContext builderContext) {
          return SizedBox(
            height: 300,
            child: Column(
              children: [
                // Bar atas dengan tombol OK
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(builderContext).pop();
                    },
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        color: CupertinoColors.activeBlue,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                // Picker waktu
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: tempPickedTime,
                    use24hFormat: true,
                    onDateTimeChanged: (DateTime newTime) {
                      tempPickedTime = newTime;
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );

      // Gabungkan tanggal dan waktu
      final DateTime combined = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        tempPickedTime.hour,
        tempPickedTime.minute,
        tempPickedTime.second,
      );

      mulai.value = combined;

      // Format jadi yyyy-MM-dd HH:mm (tanpa detik)
      final String formatted =
          '${combined.year.toString().padLeft(4, '0')}-'
          '${combined.month.toString().padLeft(2, '0')}-'
          '${combined.day.toString().padLeft(2, '0')} '
          '${combined.hour.toString().padLeft(2, '0')}:'
          '${combined.minute.toString().padLeft(2, '0')}:'
          '${combined.second.toString().padLeft(2, '0')}';

      selesaiController.text = formatted;
    }
  }

  Future<void> getLembur() async {
    isLoading.value = true;

    try {
      var result = await _lemburService.getLembur(bulan.value.toString());
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
        return {'label': 'Dalam Pengerjaan', 'color': Colors.orange};
      case 2:
        return {'label': 'Dalam Pengecekan', 'color': Colors.blue};
      case 3:
        return {'label': 'Selesai', 'color': Colors.green};
      default:
        return {'label': 'Belum Selesai', 'color': Colors.red};
    }
  }

  Map<String, dynamic> getStatusInfoFromLabel(String? label) {
    switch (label) {
      case 'Dalam Pengerjaan':
        return {'status': 1, 'color': Colors.orange};
      case 'Dalam Pengecekan':
        return {'status': 2, 'color': Colors.blue};
      case 'Selesai':
        return {'status': 3, 'color': Colors.green};
      default:
        return {'status': 0, 'color': Colors.grey};
    }
  }

  Future<void> hapusLembur(int id) async {
    isLoading.value = true;
    try {
      var result = await _lemburService.hapusLembur(id);

      if (result['status'] == true) {
        Get.back(); // Tutup BottomSheet

        Future.delayed(Duration(milliseconds: 200), () {
          Get.snackbar(
            'Berhasil',
            'Data berhasil dihapus',
            snackPosition: SnackPosition.BOTTOM,
          );

          getLembur();

          // Trik: Gunakan Get.offNamed() dengan transition zero
          Get.offNamed('/lembur', arguments: null);
        });
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

  Future<void> updateLembur(int id) async {
    final uraian_pekerjaan = keteranganController.text;
    final status = selectedValue.value;

    try {
      final result = await _lemburService.updateLembur(
        id,
        status,
        uraian_pekerjaan,
      );
      if (result['status'] == true) {
        Get.back(); // Tutup BottomSheet

        Future.delayed(Duration(milliseconds: 200), () {
          Get.snackbar(
            'Berhasil',
            'Data berhasil disimpan',
            snackPosition: SnackPosition.BOTTOM,
          );

          getLembur();

          // Trik: Gunakan Get.offNamed() dengan transition zero
          Get.offNamed('/lembur', arguments: null);
        });

        // Kosongkan form
        tanggalController.clear();
        mulaiController.clear();
        selesaiController.clear();
        keteranganController.clear();
        pilihanController.clear();
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
        print(result);
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

  Future<void> postLembur() async {
    final tanggal = tanggalController.text;
    final mulai = mulaiController.text;
    final selesai = selesaiController.text;
    final uraian_pekerjaan = keteranganController.text;
    final status =
        getStatusInfoFromLabel(pilihanController.text)['status'] ?? 0;

    isLoading.value = true;

    try {
      if (tanggal.isEmpty ||
          mulai.isEmpty ||
          selesai.isEmpty ||
          uraian_pekerjaan.isEmpty ||
          pilihanController.text.isEmpty) {
        Get.snackbar(
          'Gagal',
          'Semua field harus diisi',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final result = await _lemburService.postLembur(
        tanggal,
        mulai,
        selesai,
        uraian_pekerjaan,
        status,
      );

      if (result['status'] == true) {
        Get.back(); // Tutup BottomSheet

        Future.delayed(Duration(milliseconds: 200), () {
          Get.snackbar(
            'Berhasil',
            'Data berhasil dihapus',
            snackPosition: SnackPosition.BOTTOM,
          );

          getLembur();

          // Trik: Gunakan Get.offNamed() dengan transition zero
          Get.offNamed('/lembur', arguments: null);
        });

        // Kosongkan form
        tanggalController.clear();
        mulaiController.clear();
        selesaiController.clear();
        keteranganController.clear();
        pilihanController.clear();
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
        print(result);
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
    getLembur();
    super.onInit();
  }
}
