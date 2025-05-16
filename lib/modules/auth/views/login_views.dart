import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/app_text_style.dart';
import 'package:gopresent/modules/auth/controllers/login_controller.dart';
import 'package:gopresent/services/theme_service.dart';

class LoginViews extends StatelessWidget {
  LoginViews({super.key});

  final LoginController loginController = Get.find<LoginController>();
final themeService = Get.find<ThemeService>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: Get.height,
              child: Column(
                children: [
                  Container(
                    color: Colors.blue,
                    height: Get.height * 0.45,
                    child: Column(
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
                        SizedBox(
                          height: Get.height * 0.25,
                          child: Image.asset('assets/image/logo-login.png'),
                        ),
                        SizedBox(height: Get.height * 0.03),
                        Text(
                          'Hi, Welcome Back',
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: Get.height * 0.55,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Container nama
                        SizedBox(
                          width: Get.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  'Username',
                                  style: AppTextStyles.topForm(context),
                                ),
                              ),
                              SizedBox(height: 8),
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: Get.width * 0.95,
                                  child: TextField(
                                    controller: loginController.usernameController,
                                    decoration: const InputDecoration(
                                      // labelText: 'Username',
                                      hintText: 'Masukkan username',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),

                        //Container Password
                        SizedBox(
                          width: Get.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  'Password',
                                  style: AppTextStyles.topForm(context),
                                ),
                              ),
                              SizedBox(height: 8),
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: Get.width * 0.95,
                                  child: Obx((){
                                    return TextField(
                                      controller: loginController.passwordController,
                                    obscureText:
                                        !loginController
                                            .isPasswordVisible
                                            .value,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          loginController.togglePasswordVisibility();
                                        },
                                        icon: Icon(
                                          loginController
                                                  .isPasswordVisible
                                                  .value
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
                                      // labelText: 'Username',
                                      hintText: 'Masukkan Password',
                                    ),
                                  );
                                  })
                                  
                                  
                                  
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        SizedBox(
                          width: Get.width * 0.8,
                          height: Get.height * 0.05,
                          child: ElevatedButton(
                            onPressed: () {
                              loginController.isLoading.value ? null : loginController.login();
                            },
                            child: Text(
                              'Login',
                              style: AppTextStyles.buttonColor(context),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.15),
                        Text(
                          'Copyright 2025',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
