import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilView extends StatelessWidget {
  const ProfilView({super.key});

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
                  final box = GetStorage();
                  box.remove('token');
                  Get.offAndToNamed('/login');
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
