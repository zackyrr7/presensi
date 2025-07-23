import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBottomSheet extends StatelessWidget {
  const HomeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment:
        //     CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Tombol X di kiri atas
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.cancel, size: 30),
                  ),
                ),
              ),

              // Judul di tengah
              Center(
                child: Text(
                  "Semua Menu",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            // height: Get.height * 0.23,
            // width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/izin');
                          },
                          child: SizedBox(
                            height: Get.height * 0.08,
                            width: Get.height * 0.08,

                            child: Image.asset("assets/icon/izin.png"),
                          ),
                        ),
                        Text('Izin'),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/sakit');
                          },
                          child: SizedBox(
                            height: Get.height * 0.08,
                            width: Get.height * 0.08,

                            child: Image.asset("assets/icon/sakit.png"),
                          ),
                        ),
                        Text('Sakit'),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/cuti');
                          },
                          child: SizedBox(
                            height: Get.height * 0.08,
                            width: Get.height * 0.08,

                            child: Image.asset("assets/icon/cuti.png"),
                          ),
                        ),
                        Text('Cuti'),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/todo');
                          },
                          child: SizedBox(
                            height: Get.height * 0.08,
                            width: Get.height * 0.08,

                            child: Image.asset("assets/icon/task.png"),
                          ),
                        ),
                        Text('Todo List'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/amal');
                          },
                          child: SizedBox(
                            height: Get.height * 0.08,
                            width: Get.height * 0.08,

                            child: Image.asset("assets/icon/amal-yaumi.png"),
                          ),
                        ),
                        Text('Amal Yaumi'),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/lapker');
                          },
                          child: SizedBox(
                            height: Get.height * 0.08,
                            width: Get.height * 0.08,

                            child: Image.asset("assets/icon/lapker.png"),
                          ),
                        ),
                        Text('Lap. Kerja'),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/gaji');
                          },
                          child: SizedBox(
                            height: Get.height * 0.08,
                            width: Get.height * 0.08,

                            child: Image.asset("assets/icon/slip.png"),
                          ),
                        ),
                        Text('Slip Gaji'),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              Container(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: Column(
                                  children: [Text("Semua Menu"), Container()],
                                ),
                              ),
                            );
                          },
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed('/lembur');
                            },
                            child: SizedBox(
                              height: Get.height * 0.08,
                              width: Get.height * 0.08,
                              child: Image.asset("assets/icon/lembur.png"),
                            ),
                          ),
                        ),
                        Text('Lembur'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
