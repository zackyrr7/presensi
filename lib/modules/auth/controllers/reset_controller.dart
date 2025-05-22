import 'package:get/get.dart';
import 'package:gopresent/modules/home/controllers/home_controller.dart';

class ResetController extends GetxController {
  void resetHome() async {
   final homeController = Get.find<HomeController>();
    homeController.homeToday();
  }
}
