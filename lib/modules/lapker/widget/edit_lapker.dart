import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/lapker/controller/lapker_controller.dart';

class EditLapker extends StatelessWidget {
  EditLapker({super.key});

  final LapkerController lapkerController = Get.find<LapkerController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Tambah',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        // todolistController.resetFilter2();
                        Get.back();
                      },
                      icon: Icon(Icons.cancel, size: 30),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(color: Colors.black),
                readOnly: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  labelText: 'Tanggal',
                  labelStyle: TextStyle(color: Colors.black38),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () => lapkerController.pickDate2(context, true),
                controller: lapkerController.tambahTanggalController,
              ),

              SizedBox(height: 10),
              TextFormField(
                controller: lapkerController.penggunaController,
                style: TextStyle(color: Colors.black),

                decoration: InputDecoration(
                  fillColor: Colors.white,
                  labelText: 'Pengguna Output',
                  labelStyle: TextStyle(color: Colors.black38),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: lapkerController.uraianController,
                style: TextStyle(color: Colors.black),
                maxLines: 5,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  labelText: 'Uraian Pekerjaan',
                  labelStyle: TextStyle(color: Colors.black38),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: lapkerController.pilihanController,
                style: TextStyle(color: Colors.black),
                readOnly: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  labelText: 'Jenis pekerjaan',
                  labelStyle: TextStyle(color: Colors.black38),
                ),
                onTap: () {
                  final List<String> options = [
                    "Dalam Pengerjaan",
                    "Dalam Pengecekan",
                    "Selesai",
                  ];

                  Get.defaultDialog<String>(
                    title: "Pilih Status Pekerjaan",
                    content: Column(
                      children:
                          options.map((item) {
                            return ListTile(
                              title: Text(item),

                              onTap: () {
                                Get.back(result: item);
                                if (item != null) {
                                  lapkerController.pilihanController.text =
                                      item;
                                }
                              },
                            );
                          }).toList(),
                    ),
                    radius: 10,
                  );
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      minimumSize: Size(140, 50),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      Get.offAllNamed('/navbar');
                      Future.delayed(Duration(milliseconds: 100), () {
                        Get.toNamed('/lapker');
                      });
                      lapkerController.hapusLapker();
                    },
                    child: Text('hapus'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      minimumSize: Size(140, 50),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      Get.offAllNamed('/navbar');
                      Future.delayed(Duration(milliseconds: 100), () {
                        Get.toNamed('/lapker');
                      });
                      lapkerController.Edit();
                    },
                    child: Text('Simpan'),
                  ),
                ],
              ),

              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
