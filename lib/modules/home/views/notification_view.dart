import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/home/controllers/notification_controller.dart';

class NotificationView extends StatelessWidget {
  NotificationView({super.key});
  final notificationController = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NOTIFIKASI',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (notificationController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: notificationController.listnotification.length,
            itemBuilder: (context, index) {
              final notification =
                  notificationController.listnotification[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      '/notification-detail',
                      arguments: notification,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    width: Get.width,
                    padding: EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          child: Icon(Icons.calendar_month),
                          backgroundColor:
                              Theme.of(context).colorScheme.onPrimaryFixed,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notificationController
                                    .listnotification[index]
                                    .title,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(
                                notificationController
                                    .listnotification[index]
                                    .message,
                                maxLines: 2, // Supaya bisa turun ke bawah
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
