import 'package:get/get.dart';

import 'package:gopresent/modules/home/controllers/home_controller.dart';
import 'package:gopresent/modules/home/controllers/notification_controller.dart';
import 'package:gopresent/modules/izin/controller/izin_controller.dart';
import 'package:gopresent/modules/riwayat/controller/riwayat_hitung_controller.dart';
import 'package:gopresent/modules/sakit/controller/sakit_controller.dart';

class Sakitbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SakitController>((SakitController()), permanent: true);
  }
}
