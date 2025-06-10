import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gopresent/modules/auth/controllers/reset_controller.dart';
import 'package:gopresent/modules/home/controllers/home_controller.dart';
import 'package:gopresent/services/absen_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class AbsenController extends GetxController {
  var isLoading = false.obs;
  Rx<DateTime> currentTime = DateTime.now().obs;
  late Timer _timer;
  final ImagePicker picker = ImagePicker();
  var imageFile = Rxn<File>();
  final AbsenService _absenService = AbsenService();
  final ResetController resetController = Get.find<ResetController>();
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isMockLocation = false.obs;

  var type = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _startClock();
  }

  void _startClock() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      currentTime.value = DateTime.now();
    });
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    //periksa lokasi di aktifkan
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Lokasi Tidak aktif', 'Harap Aktifkan layanan lokasi anda');
      return;
    }

    //periksa izin
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Izin Di tolak', 'Harap Berikan izin lokasi anda');
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Izin Ditolak Permanen",
        "Buka pengaturan untuk memberikan izin.",
      );
      return;
    }

    //ambil Lokasi
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    latitude.value = position.latitude;
    longitude.value = position.longitude;
    isMockLocation.value = position.isMocked;

    if (isMockLocation.value) {
      Get.snackbar('Peringatan!!', 'Anda Terdeteksi menggunakan lokasi palsu');
      return;
    }

    //   Get.snackbar(
    //     'berhasil',
    //     '${position.latitude}, ${position.longitude}',
    //     snackPosition: SnackPosition.BOTTOM,
    //   );

    Get.toNamed('/absen-create');
    deleteFoto();
  }

  Future<void> takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      final File originalFile = File(pickedFile.path);
      final String extension = path.extension(originalFile.path).toLowerCase();

      // Baca bytes dari file
      final Uint8List bytes = await originalFile.readAsBytes();

      // Decode image menggunakan package image
      final img.Image? image = img.decodeImage(bytes);
      if (image == null) {
        return;
      }

      // Resize gambar (contoh: max width 800px)
      final img.Image resizedImage = img.copyResize(image, width: 800);

      // Encode sebagai JPG dengan kualitas rendah (0–100)
      final List<int> jpg = img.encodeJpg(resizedImage, quality: 85);

      // Simpan ke direktori sementara
      final Directory tempDir = await getTemporaryDirectory();
      final String fileName =
          'converted_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = path.join(tempDir.path, fileName);
      final File convertedFile = File(filePath)..writeAsBytesSync(jpg);

      // Simpan ke Rx variable kamu
      imageFile.value = convertedFile;
    }
  }

  Future<void> deleteFoto() async {
    imageFile.value = null;
  }

  Future<void> cekInOut() async {
    isLoading.value = true;

    try {
      var result = await _absenService.cekInOut();

      if (result['status'] == true) {
        type.value = result['data']['type'] ?? '';
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

  Future<void> simpanAbsen() async {
    final clock_type = type.value;
    final location = '${latitude.value}, ${longitude.value}';
    final file = imageFile.value;
    isLoading.value = true;

    try {
      if (clock_type.isEmpty || location.isEmpty) {
        Get.snackbar(
          'Gagal',
          'Semua field harus diisi',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      if (file == null) {
        Get.snackbar(
          'Gagal',
          'Silakan ambil foto terlebih dahulu.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      var result = await _absenService.postAbsen(clock_type, location, file);

      if (result['status'] == true) {
        Get.snackbar(
          'Berhasil',
          result['message'] ?? 'Data berhasil disimpan',
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.until((route) => Get.currentRoute == '/navbar');
        resetController.resetHome();
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
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
