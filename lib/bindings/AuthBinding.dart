import 'package:get/get.dart';
import 'package:gopresent/modules/auth/controllers/login_controller.dart';


class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>((LoginController()));
  
  }
}