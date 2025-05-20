import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/riwayat/controller/riwayat_hitung_controller.dart';
import 'package:gopresent/modules/riwayat/widget/grid_riwayat.dart';

class RiwayatView extends StatelessWidget {
  RiwayatView({super.key});
  final RiwayatHitungController riwayatHitungController =
      Get.find<RiwayatHitungController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Riwayat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ),
      body: Column(children: [GridRiwayat()]),
    );
  }
}
