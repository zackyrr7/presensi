import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/lembur/controller/lembur_controller.dart';
import 'package:gopresent/modules/lembur/model/lembur_model.dart';
import 'package:gopresent/modules/lembur/widget/bottom_sheet_ubah_status.dart';
import 'package:gopresent/modules/lembur/widget/create_bottom_sheet_lembur.dart';

class LemburDetailView extends StatelessWidget {
  LemburDetailView({super.key});
  final LemburController lemburController = Get.find<LemburController>();

  @override
  Widget build(BuildContext context) {
    final LemburItem lembur = Get.arguments;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          lembur.tanggal,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: Get.height * 0.7,
            width: Get.width * 0.9,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Waktu Mulai & Selesai
                Table(
                  columnWidths: const {
                    0: IntrinsicColumnWidth(),
                    1: FixedColumnWidth(10),
                    2: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(
                      children: [
                        Text(
                          'Mulai',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(':'),
                        Text(lembur.mulai),
                      ],
                    ),
                    TableRow(
                      children: [SizedBox(height: 8), Text(''), Text('')],
                    ),
                    TableRow(
                      children: [
                        Text(
                          'Selesai',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(':'),
                        Text(lembur.selesai),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                Divider(),

                Text(
                  'Uraian Pekerjaan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // ✅ ListView harus dibungkus dengan SizedBox atau Expanded
                Expanded(
                  // atur sesuai kebutuhan
                  child: ListView.builder(
                    itemCount: lembur.data.length,
                    itemBuilder: (context, index) {
                      final detail = lembur.data[index];
                      final statusInfo = lemburController.getStatusInfo(
                        detail.status,
                      );
                      return Container(
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).colorScheme.onTertiary,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    detail.uraianPekerjaan,
                                    textAlign: TextAlign.justify,

                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    statusInfo['label'],
                                    style: TextStyle(
                                      color: statusInfo['color'],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            detail.status != 3
                                ? IconButton(
                                  onPressed: () {
                                    Get.bottomSheet(
                                      BottomSheetUbahStatus(
                                        index: index,
                                        detail: detail,
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.edit),
                                )
                                : Container(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
        onPressed: () {
          Get.bottomSheet(CreateBottomSheetLembur());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
