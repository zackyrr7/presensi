import 'package:get/get.dart';

import 'package:gopresent/modules/home/controllers/home_controller.dart';
import 'package:gopresent/modules/riwayat/controller/riwayat_hitung_controller.dart';

class Homebinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>((HomeController()));
    Get.put<RiwayatHitungController>((RiwayatHitungController()));
  }
}
