import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/constant.dart';
import 'package:gopresent/modules/profil/controller/profile_controller.dart';
import 'package:gopresent/modules/profil/model/profile_model.dart';
import 'package:image_picker/image_picker.dart';

class PopupUbahFoto extends StatelessWidget {
  const PopupUbahFoto({
    super.key,
    required this.profileController,
    required this.pegawai,
  });

  final ProfileController profileController;
  final DetailPegawai? pegawai;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
            children: [
              Text(
                'Foto Profil',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed:
                    () => Get.back(),
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.3,
            width: Get.width * 0.85,
            child: Obx(() {
              if (profileController
                      .imageFile
                      .value ==
                  null) {
                return Image.network(
                  '$urlFoto${pegawai!.foto}',
                );
              } else {
                return Image.file(
                  profileController
                      .imageFile
                      .value!,
                );
              }
            }),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  popUpAsalFoto(context);
                },
                style:
                    ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.green,
                    ),
                child: Text('Ubah foto'),
              ),
              Obx(() {
                if (profileController
                        .imageFile
                        .value ==
                    null) {
                  return ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Kembali',
                    ),
                  );
                } else {
                  return Container();
                }
              }),
              Obx(() {
                if (profileController
                        .imageFile
                        .value !=
                    null) {
                  return ElevatedButton(
                    onPressed: () {
                      profileController.deleteFoto();
                    },
                    child: Text(
                      'Hapus Foto',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors
                              .red, // contoh styling
                      foregroundColor:
                          Colors.white,
                    ),
                  );
                } else {
                  return Container();
                }
              }),
            ],
          ),
          SizedBox(height: 8),
          Obx(() {
            if (profileController
                    .imageFile
                    .value !=
                null) {
              return ElevatedButton(
                onPressed: () {
                  profileController.updatePhoto();
                },
                child: Text('Simpan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue
                ),
              );
            } else {
              return Container();
            }
          }),
        ],
      ),
    );
  }

  Future<dynamic> popUpAsalFoto(BuildContext context) {
    return Get.defaultDialog(
                  title: "Ubah Foto",
                  content: Text(
                    "Pilih darimana foto mau diambil:",
                  ),
                  cancel: TextButton(
                    onPressed: () {
                      Get.back();
                      profileController
                          .takePhoto(
                            ImageSource
                                .camera,
                          );
                    },
                    child: Text(
                      "Kamera",
                      style: TextStyle(
                        color:
                            Theme.of(
                                  context,
                                )
                                .textTheme
                                .bodySmall!
                                .color,
                      ),
                    ),
                  ),
                  confirm: TextButton(
                    onPressed: () {
                      Get.back(); // tutup dialog
                      profileController
                          .takePhoto(
                            ImageSource
                                .gallery,
                          );
                    },
  
                    child: Text(
                      "Galeri",
                      style: TextStyle(
                        color:
                            Theme.of(
                                  context,
                                )
                                .textTheme
                                .bodySmall!
                                .color,
                      ),
                    ),
                  ),
                );
  }
}
