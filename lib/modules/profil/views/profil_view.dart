import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gopresent/modules/auth/controllers/reset_controller.dart';

class ProfilView extends StatelessWidget {
  ProfilView({super.key});
  final ResetController resetController = Get.find<ResetController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: Get.height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  resetController.deleteSession();
                },
                icon: Icon(Icons.logout),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
