import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/home/widget/home_bottomSheet.dart';

class GridContainer extends StatelessWidget {
  const GridContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.23,
      width: Get.width,

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
                    onTap: () {},
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
                    onTap: () {},
                    child: SizedBox(
                      height: Get.height * 0.08,
                      width: Get.height * 0.08,

                      child: Image.asset("assets/icon/task.png"),
                    ),
                  ),
                  Text('Task'),
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
                    onTap: () {},
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
                    onTap: () {},
                    child: SizedBox(
                      height: Get.height * 0.08,
                      width: Get.height * 0.08,

                      child: Image.asset("assets/icon/lapker.png"),
                    ),
                  ),
                  Text('Aktivitas'),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {},
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
                      Get.bottomSheet(HomeBottomSheet());
                    },
                    child: SizedBox(
                      height: Get.height * 0.08,
                      width: Get.height * 0.08,

                      child: Image.asset("assets/icon/lainnya.png"),
                    ),
                  ),
                  Text('Lainnya'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
