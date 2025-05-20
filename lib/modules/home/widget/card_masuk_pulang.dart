import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/home/controllers/home_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class CardMasukPulang extends StatelessWidget {
   CardMasukPulang({
    super.key,
    
  });
  final HomeController homeController = Get.find<HomeController>();

 



  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        height: Get.height * 0.23,
        width: Get.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Column(
          children: [
            Obx(() {
              if (homeController.isLoading.value) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color:
                          Theme.of(context).colorScheme.onPrimaryFixed,
                      size: 20,
                    ),
                  ),
                );
              }
              return Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text(
                    homeController.tanggal.string,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() {
                  if (homeController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Container(
                      height: Get.height * 0.15,
                      width: Get.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:
                            Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Masuk', style: TextStyle(fontSize: 15)),
                          SizedBox(height: 5,),
                          Text(
                            homeController.jamMasuk.string,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                homeController.statusMasuk.string,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),
                //jam pulang
               Obx(() {
                  if (homeController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Container(
                      height: Get.height * 0.15,
                      width: Get.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:
                            Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Pulang', style: TextStyle(fontSize: 15)),
                          SizedBox(height: 5,),
                          Text(
                            homeController.jamPulang.string,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                homeController.statusPulang.string,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}