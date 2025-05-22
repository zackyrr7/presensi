import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/home/controllers/notification_controller.dart';
import 'package:gopresent/modules/home/model/notification_model.dart';

class NotificationDetailView extends StatelessWidget {
  NotificationDetailView({super.key});
  final NotificationController notificationController =
      Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    final NotificationModel notification = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              notification.title,
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
          ],
        ),
        toolbarHeight: 80, // Tambahkan tinggi jika perlu ruang untuk 2 baris
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          notification.message,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
