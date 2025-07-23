import 'package:get/get.dart';
import 'package:gopresent/modules/absen/controller/absen_controller.dart';
import 'package:gopresent/modules/amal/controller/amal_controller.dart';
import 'package:gopresent/modules/auth/controllers/login_controller.dart';

class AmalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AmalController>((AmalController()), permanent: true);
  }
}
