import 'package:get/get.dart';
import 'package:gopresent/modules/amal/controller/amal_controller.dart';
import 'package:gopresent/modules/cuti/controller/cuti_controller.dart';
import 'package:gopresent/modules/gaji/controller/gaji_controller.dart';
import 'package:gopresent/modules/home/controllers/home_controller.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gopresent/modules/izin/controller/izin_controller.dart';
import 'package:gopresent/modules/lapker/controller/lapker_controller.dart';
import 'package:gopresent/modules/lembur/controller/lembur_controller.dart';
import 'package:gopresent/modules/profil/controller/profile_controller.dart';
import 'package:gopresent/modules/riwayat/controller/riwayat_hitung_controller.dart';
import 'package:gopresent/modules/sakit/controller/sakit_controller.dart';
import 'package:gopresent/modules/todolist/controller/todolist_controller.dart';

class ResetController extends GetxController {
  void resetHome() async {
    final homeController = Get.find<HomeController>();
    homeController.homeToday();
    homeController.getListAbsensToday();
  }

  void deleteSession() {
    Get.delete<HomeController>();
    Get.delete<ProfileController>(force: true);
    Get.delete<SakitController>(force: true);
    Get.delete<IzinController>(force: true);
    Get.delete<RiwayatHitungController>(force: true);
    Get.delete<CutiController>(force: true);
    Get.delete<LemburController>(force: true);
    Get.delete<GajiController>(force: true);
    Get.delete<AmalController>(force: true);
    Get.delete<TodolistController>(force: true);
    Get.delete<LapkerController>(force: true);

    GetStorage box = GetStorage();
    box.remove('token');
    Get.toNamed('/login');
  }
}
