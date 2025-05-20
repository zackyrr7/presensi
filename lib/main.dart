import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:gopresent/app_theme.dart';
import 'package:gopresent/routes/app_pages.dart';
import 'package:gopresent/services/theme_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

void main() async {
  await GetStorage.init();
  Get.put(ThemeService());
  runApp(const MyApp());

  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeService().theme,
      getPages: AppPages.routes,
      initialRoute: GetStorage().hasData('token') ? Routes.NAVBAR : Routes.LOGIN,
    );
  }
}
