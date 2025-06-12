import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gopresent/constant.dart';
import 'package:gopresent/modules/auth/controllers/login_controller.dart';
import 'package:gopresent/modules/auth/controllers/reset_controller.dart';
import 'package:gopresent/modules/profil/controller/profile_controller.dart';
import 'package:gopresent/modules/profil/model/profile_model.dart';
import 'package:gopresent/modules/profil/widget/popup_detail_pegawai.dart';
import 'package:gopresent/modules/profil/widget/popup_ubahfoto.dart';
import 'package:gopresent/services/theme_service.dart';
import 'package:image_picker/image_picker.dart';

class ProfilView extends StatelessWidget {
  ProfilView({super.key});
  final ResetController resetController = Get.find<ResetController>();
  final ProfileController profileController = Get.find<ProfileController>();
  final ThemeService themeService = Get.find<ThemeService>();
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (profileController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          final pegawai = profileController.detailPegawai.value;
          return Column(
            children: [
              SizedBox(height: Get.height * 0.07),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 10, 0),
                child: Container(
                  width: Get.width,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    '$urlFoto${pegawai!.foto}',
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    // Aksi saat ikon edit ditekan
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.defaultDialog(
                                          title: '',
                                          titlePadding: EdgeInsets.zero,

                                          content: PopupUbahFoto(
                                            profileController:
                                                profileController,
                                            pegawai: pegawai,
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pegawai.namaPegawai,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 2),

                              Row(
                                children: [
                                  Icon(Icons.work),
                                  SizedBox(width: 5),
                                  Text(pegawai.jabatan),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                            backgroundColor: Colors.white,
                            title: 'Profil Pegawai',
                            titleStyle: TextStyle(color: Colors.black),
                            content: PopupDetailPegawai(pegawai: pegawai),
                          );
                        },
                        icon: Icon(Icons.library_books, size: 30),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Get.defaultDialog(
                      title: "Ubah Password",
                      content: Container(
                        width: Get.width * 0.8,
                        child: Column(
                          children: [
                            Obx(() {
                              return TextField(
                                controller:
                                    profileController.passwordLamaController,
                                obscureText:
                                    !profileController
                                        .isOldPasswordVisible
                                        .value,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      profileController
                                          .oldtogglePasswordVisibility();
                                    },
                                    icon: Icon(
                                      profileController
                                              .isOldPasswordVisible
                                              .value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  labelText: 'Password Baru',
                                ),
                              );
                            }),
                            SizedBox(height: 12),

                            Obx(() {
                              return TextField(
                                controller:
                                    profileController.passwordBaruController,
                                obscureText:
                                    !profileController
                                        .isNewPasswordVisible
                                        .value,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      profileController
                                          .newtogglePasswordVisibility();
                                    },
                                    icon: Icon(
                                      profileController
                                              .isNewPasswordVisible
                                              .value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  labelText: 'Konfirmasi Password',
                                ),
                              );
                            }),
                            SizedBox(height: 8),
                            Container(
                              child: Column(
                                children: const [
                                  ListTile(
                                    leading: SizedBox(
                                      width:
                                          24, // batasi lebar supaya tidak makan seluruh tile
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          "•",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.amber,
                                          ), // ukuran lebih kecil & aman
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      "Pastikan Sandi Baru anda Berbeda dengan Sandi saat ini",
                                      style: TextStyle(
                                        color: Colors.amber,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                  ),
                                  ListTile(
                                    leading: SizedBox(
                                      width:
                                          24, // batasi lebar supaya tidak makan seluruh tile
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          "•",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.amber,
                                          ), // ukuran lebih kecil & aman
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      "Minimal Panjang sandi 8 digit",
                                      style: TextStyle(
                                        color: Colors.amber,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                  ),
                                  ListTile(
                                    leading: SizedBox(
                                      width:
                                          24, // batasi lebar supaya tidak makan seluruh tile
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          "•",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.amber,
                                          ), // ukuran lebih kecil & aman
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      "Agar Lebih aman, silahkan gunakan huruf, angka dan karakter unik",
                                      style: TextStyle(
                                        color: Colors.amber,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                profileController.updatePassword();
                              },
                              child: Text("Simpan"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    // color: Colors.amber,
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.lock, size: 30),
                            SizedBox(width: 8),
                            Text(
                              'Ubah Password',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    // color: Colors.amber,
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.dark_mode, size: 30),
                            SizedBox(width: 8),
                            Text(
                              'Mode Gelap',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Obx(() {
                            return Switch(
                              value: themeService.isDarkMode.value,
                              onChanged: (val) {
                                themeService.switchTheme();
                                themeService.isDarkMode.value = val;
                              },
                              activeColor: Colors.white,
                              inactiveThumbColor: Colors.blue,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: resetController.deleteSession,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  width: Get.width * 0.9,
                  height: Get.height * 0.05,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Keluar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
