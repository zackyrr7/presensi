import 'package:get/get.dart';
import 'package:gopresent/modules/absen/controller/absen_controller.dart';
import 'package:gopresent/modules/auth/controllers/login_controller.dart';


class Absenbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AbsenController>((AbsenController()));
  
  }
}