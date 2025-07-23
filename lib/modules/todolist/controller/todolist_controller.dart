import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/auth/controllers/reset_controller.dart';
import 'package:gopresent/modules/todolist/model/todolist_model.dart';
import 'package:gopresent/services/todo_service.dart';
import 'package:intl/intl.dart';

class TodolistController extends GetxController {
  final resetController = Get.find<ResetController>();
  var isLoading = false.obs;
  final TodoService _todoService = TodoService();
  var todoListModel = <TodoListModel>[].obs;
  RxInt filter = 9.obs;
  var filterTodoList = DateTime.now().toString().substring(0, 10).obs;
  var tanggal = ''.obs;
  var tanggalFormated = ''.obs;
  var tanggalAwal = Rxn<DateTime>();
  final tanggalAwalController = TextEditingController();
  final pilihanController = TextEditingController();
  final pilihanController2 = TextEditingController();
  final tambahTanggalController = TextEditingController();
  final tambahKeteranganController = TextEditingController();

  void resetFilter() {
    pilihanController2.clear();
    pilihanController.text = '';
    tanggalAwalController.clear();
  }

  void resetFilter2() {
    tambahTanggalController.clear();
    tambahKeteranganController.clear();
  }

  String formatTanggal() {
    if (tanggalAwalController.text.isEmpty) {
      return DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(DateTime.now());
    }
    try {
      DateTime dateTime = DateTime.parse(tanggalAwalController.text);
      return DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(dateTime);
    } catch (e) {
      return '-';
    }
  }

  String format(DateTime? date) {
    if (date == null) return '';
    return DateFormat('yyyy-MM-dd').format(date);
  }

  void toggleIsDoneById(int id, bool newValue) {
    final todo = todoListModel.firstWhereOrNull((e) => e.id == id);
    if (todo != null) {
      final newInt = newValue ? 1 : 0;
      if (todo.isDone != newInt) {
        todo.isDone.value = newInt;
      }
    }
  }

  Future<void> pickDate(BuildContext context, bool isStart) async {
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
        tanggalAwalController.text = format(picked); // update text
      }
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

  Future<void> getTodoList() async {
    isLoading.value = true;
    String filterTodoList2;
    if (tanggalAwalController.text.isEmpty) {
      filterTodoList2 = filterTodoList.toString();
    } else {
      filterTodoList2 = tanggalAwalController.value.text;
    }

    int filter2;
    if (pilihanController2.text.isEmpty) {
      filter2 = filter.toInt();
    } else {
      filter2 = int.tryParse(pilihanController2.text) ?? filter.toInt();
    }

    try {
      var result = await _todoService.getTodo(filter2, filterTodoList2);

      if (result['success'] == true) {
        todoListModel.value = TodoListModel.fromJsonList(result['data']);

        // Ambil tanggal pertama jika ada data
        if (todoListModel.isNotEmpty) {
          tanggal.value = todoListModel.first.tanggal ?? '';
        } else {
          tanggal.value = '';
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

  Future<void> changeStatus(int id, int status) async {
    try {
      var result = await _todoService.updateIsdone(id, status);
      if (result['success'] = true) {
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
    }
  }

  Future<void> simpanTodo() async {
    isLoading.value = true;
    final tanggal = tambahTanggalController.text;
    final nama = tambahKeteranganController.text;

    try {
      if (tanggal.isEmpty || nama.isEmpty) {
        Get.snackbar(
          'Gagal',
          'Semua field harus diisi',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      var result = await _todoService.tambahToDo(tanggal, nama);

      if (result['status'] == true) {
        Get.snackbar(
          'Berhasil',
          'Data berhasil disimpan',
          snackPosition: SnackPosition.BOTTOM,
        );
        getTodoList();
        resetFilter2();
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

  Future<void> updateTodo(int id) async {
    isLoading.value = true;
    final tanggal = tambahTanggalController.text;
    final nama = tambahKeteranganController.text;

    try {
      if (tanggal.isEmpty || nama.isEmpty) {
        Get.snackbar(
          'Gagal',
          'Semua field harus diisi',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      var result = await _todoService.update(id, tanggal, nama);

      if (result['status'] == true) {
        Get.snackbar(
          'Berhasil',
          'Data berhasil disimpan',
          snackPosition: SnackPosition.BOTTOM,
        );
        getTodoList();
        resetFilter2();
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

  Future<void> hapusTodo(int id) async {
    isLoading.value = true;

    try {
      var result = await _todoService.hapus(id);

      if (result['status'] == true) {
        Get.snackbar(
          'Berhasil',
          'Data berhasil dihapus',
          snackPosition: SnackPosition.BOTTOM,
        );
        getTodoList();
        resetFilter2();
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
    getTodoList();

    tanggalAwalController.addListener(() {
      getTodoList();
    });

    pilihanController2.addListener(() {
      getTodoList();
    });
    // TODO: implement onInit
    super.onInit();
  }
}
