import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/auth/controllers/reset_controller.dart';
import 'package:gopresent/modules/profil/model/profile_model.dart';
import 'package:gopresent/services/profile_service.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ProfileController extends GetxController {
  final ResetController resetController = Get.find<ResetController>();
  var isLoading = false.obs;
  final ProfileService _profileService = ProfileService();
  var detailPegawai = Rxn<DetailPegawai>();
  final ImagePicker picker = ImagePicker();
  var imageFile = Rxn<File>();
  final passwordLamaController = TextEditingController();
  final passwordBaruController = TextEditingController();

  var isNewPasswordVisible = false.obs;
  var isOldPasswordVisible = false.obs;

  void newtogglePasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void oldtogglePasswordVisibility() {
    isOldPasswordVisible.value = !isOldPasswordVisible.value;
  }

  Future<void> getProfile() async {
    isLoading.value = true;
    try {
      var result = await _profileService.getProfile();
      if (result['status'] == true) {
        detailPegawai.value = DetailPegawai.fromJson(result['data']);
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

  Future<void> takePhoto(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final File originalFile = File(pickedFile.path);
      final String extension = path.extension(originalFile.path).toLowerCase();

      // Baca bytes dari file
      final Uint8List bytes = await originalFile.readAsBytes();

      // Decode image menggunakan package image
      final img.Image? image = img.decodeImage(bytes);
      if (image == null) return;

      // Resize gambar (contoh: max width 800px)
      final img.Image resizedImage = img.copyResize(image, width: 800);

      // Encode sebagai JPG
      final List<int> jpg = img.encodeJpg(resizedImage, quality: 85);

      // Simpan ke direktori sementara
      final Directory tempDir = await getTemporaryDirectory();
      final String fileName =
          'converted_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = path.join(tempDir.path, fileName);
      final File convertedFile = File(filePath)..writeAsBytesSync(jpg);

      // Simpan ke Rx atau variable kamu
      imageFile.value = convertedFile;
    }
  }

  Future<void> deleteFoto() async {
    imageFile.value = null;
  }

  Future<void> updatePassword() async {
    isLoading.value = true;
    final password = passwordLamaController.text;
    final password2 = passwordBaruController.text;

    try {
      var result = await _profileService.updatePassword(password, password2);

      if (result['status'] == true) {
        passwordBaruController.clear();
        passwordLamaController.clear();
        Get.back();
        Get.snackbar(
          'Berhasil',
          result['message'] ?? 'Data berhasil disimpan',
          snackPosition: SnackPosition.BOTTOM,
        );
        getProfile();
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

  Future<void> updatePhoto() async {
    isLoading.value = true;
    final file = imageFile.value;

    try {
      var result = await _profileService.updatePhoto(file);

      if (result['status'] == true) {
        Get.back();
        Get.snackbar(
          'Berhasil',
          result['message'] ?? 'Data berhasil disimpan',
          snackPosition: SnackPosition.BOTTOM,
        );
        getProfile();
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
    getProfile();
    super.onInit();
  }
}
