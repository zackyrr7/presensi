import 'package:get/get.dart';

import 'package:gopresent/modules/todolist/controller/todolist_controller.dart';


class Todobinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TodolistController>((TodolistController()),permanent: true);
  
  }
}