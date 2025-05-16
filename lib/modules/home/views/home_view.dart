import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/services/theme_service.dart';

class HomeView extends StatelessWidget {
   HomeView({super.key});
  final themeService = Get.find<ThemeService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: Get.height * 0.05),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                            onPressed: () {
                              // Mengubah tema ketika tombol ditekan
                              themeService.switchTheme();
                            },
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Obx((){
                                return Icon(size: 30,
                                // Mengubah ikon sesuai dengan status tema
                                themeService.isDarkMode.value
                                    ? Icons.light_mode // Ikon untuk tema gelap
                                    : Icons.dark_mode_outlined, // Ikon untuk tema terang
                              );
                              })
                              
                              
                            ),
                          ),
          ),
        ],
      ),
    );
  }
}
