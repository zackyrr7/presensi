import 'package:get/get.dart';
import 'package:gopresent/modules/lapker/controller/lapker_controller.dart';

import 'package:gopresent/modules/todolist/controller/todolist_controller.dart';


class Lapkerbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LapkerController>((LapkerController()),permanent: true);
  
  }
}