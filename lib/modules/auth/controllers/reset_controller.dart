import 'package:get/get.dart';
import 'package:gopresent/modules/cuti/controller/cuti_controller.dart';
import 'package:gopresent/modules/home/controllers/home_controller.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gopresent/modules/izin/controller/izin_controller.dart';
import 'package:gopresent/modules/lembur/controller/lembur_controller.dart';
import 'package:gopresent/modules/riwayat/controller/riwayat_hitung_controller.dart';
import 'package:gopresent/modules/sakit/controller/sakit_controller.dart';

class ResetController extends GetxController {
  void resetHome() async {
    final homeController = Get.find<HomeController>();
    homeController.homeToday();
    homeController.getListAbsensToday();
  }

  void deleteSession() {
    Get.delete<HomeController>();
    Get.delete<IzinController>();
    Get.delete<SakitController>();
    Get.delete<RiwayatHitungController>();
    Get.delete<CutiController>();
    Get.delete<LemburController>();
    
    GetStorage box = GetStorage();
    box.remove('token');
    Get.toNamed('/login');
  }
}
