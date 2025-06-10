import 'package:get/get.dart';
import 'package:gopresent/modules/absen/controller/absen_controller.dart';
import 'package:gopresent/modules/auth/controllers/login_controller.dart';
import 'package:gopresent/modules/lembur/controller/lembur_controller.dart';

class Lemburbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LemburController>((LemburController()), permanent: true);
  }
}
