import 'package:flutter/material.dart';
import 'package:gopresent/modules/todolist/controller/todolist_controller.dart';
import 'package:get/get.dart';

class TodolistView extends StatelessWidget {
  TodolistView({super.key});
  final TodolistController todolistController = Get.find<TodolistController>();
  final List<String> options = ["Semua", "Belum Selesai", "Selesai"];

  Future<void> showPilihanDialog() async {
    final result = await Get.defaultDialog<String>(
      title: "Status",
      content: Column(
        children:
            options.map((item) {
              return ListTile(
                title: Text(item),
                onTap: () {
                  Get.back(result: item);
                },
              );
            }).toList(),
      ),
      radius: 10,
    );

    if (result != null) {
      String value;

      if (result == "Semua") {
        value = "9";
      } else if (result == "Belum Selesai") {
        value = "0";
      } else if (result == "Selesai") {
        value = "1";
      } else {
        value = "";
      }

      todolistController.pilihanController.text = result;
      todolistController.pilihanController2.text = value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'To Do List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              todolistController.resetFilter();
              todolistController.getTodoList();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Obx(() {
        if (todolistController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.onPrimary,
                ),

                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Aktivitas',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(todolistController.formatTanggal()),

                              SizedBox(height: 20),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              Get.bottomSheet(
                                Container(
                                  height: Get.height * 0.35,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(
                                          context,
                                        ).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),

                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                'Filter To Do List',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 0,
                                              child: IconButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                icon: Icon(
                                                  Icons.cancel,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          child: TextFormField(
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              labelText: 'Tanggal',
                                              labelStyle: TextStyle(
                                                color: Colors.black38,
                                              ),
                                              suffixIcon: Icon(
                                                Icons.calendar_today,
                                              ),
                                            ),
                                            onTap:
                                                () => todolistController
                                                    .pickDate(context, true),
                                            controller:
                                                todolistController
                                                    .tanggalAwalController,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      SizedBox(
                                        width: Get.width * 0.95,
                                        child: TextFormField(
                                          controller:
                                              todolistController
                                                  .pilihanController,
                                          style: TextStyle(color: Colors.black),
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            labelText: 'Jenis Pekerjaan',
                                            labelStyle: TextStyle(
                                              color: Colors.black38,
                                            ),
                                          ),
                                          onTap: () {
                                            showPilihanDialog();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.filter_alt),
                          ),
                        ],
                      ),
                      Container(
                        // color: Colors.amber,
                        height: 20,
                        width: Get.width,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey, // Warna border
                              width: 1, // Ketebalan border
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: todolistController.todoListModel.length,
                          itemBuilder: (context, index) {
                            var todolist =
                                todolistController.todoListModel![index];
                            return Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey, // Warna border
                                    width: 1, // Ketebalan border
                                  ),
                                ),
                              ),
                              child: ListTile(
                                leading: Obx(
                                  () => Transform.scale(
                                    scale: 0.8,
                                    child: Switch(
                                      value: todolist.isDone.value == 1,
                                      onChanged: (bool newValue) {
                                        final newStatus = newValue ? 1 : 0;
                                        if (todolist.isDone.value !=
                                            newStatus) {
                                          todolist.isDone.value = newStatus;
                                        }
                                        todolistController.changeStatus(
                                          todolist.id,
                                          newStatus,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                title: Text(
                                  todolist.nama,
                                  textAlign: TextAlign.justify,
                                ),
                                trailing:
                                    todolist.createdByAdmin != 1 &&
                                            todolist.isStatis != 1
                                        ? IconButton(
                                          onPressed: () {
                                            todolistController
                                                .tambahTanggalController
                                                .text = todolist.tanggal ?? '';
                                            todolistController
                                                .tambahKeteranganController
                                                .text = todolist.nama ?? '';
                                            Get.bottomSheet(
                                              Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      Theme.of(
                                                        context,
                                                      ).scaffoldBackgroundColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                      ),
                                                ),
                                                child: SingleChildScrollView(
                                                  // Tambahkan ini supaya responsif kalau isi lebih panjang
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          8.0,
                                                        ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize
                                                              .min, // Ini penting!
                                                      children: [
                                                        Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Center(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets.all(
                                                                      8.0,
                                                                    ),
                                                                child: Text(
                                                                  'Edit To Do list',
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              right: 0,
                                                              child: IconButton(
                                                                onPressed: () {
                                                                  todolistController
                                                                      .resetFilter2();
                                                                  Get.back();
                                                                },
                                                                icon: Icon(
                                                                  Icons.cancel,
                                                                  size: 30,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        TextFormField(
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                          readOnly: true,
                                                          decoration: InputDecoration(
                                                            fillColor:
                                                                Colors.white,
                                                            labelText:
                                                                'Tanggal',
                                                            labelStyle: TextStyle(
                                                              color:
                                                                  Colors
                                                                      .black38,
                                                            ),
                                                            suffixIcon: Icon(
                                                              Icons
                                                                  .calendar_today,
                                                            ),
                                                          ),
                                                          onTap:
                                                              () =>
                                                                  todolistController
                                                                      .pickDate2(
                                                                        context,
                                                                        true,
                                                                      ),
                                                          controller:
                                                              todolistController
                                                                  .tambahTanggalController,
                                                        ),
                                                        SizedBox(height: 10),
                                                        TextField(
                                                          controller:
                                                              todolistController
                                                                  .tambahKeteranganController,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                          maxLines:
                                                              5, // Ganti ini, jangan gunakan expands.
                                                          decoration: InputDecoration(
                                                            filled: true,
                                                            fillColor:
                                                                Colors.white,
                                                            labelText:
                                                                'Uraian Pekerjaan',
                                                            labelStyle: TextStyle(
                                                              color:
                                                                  Colors
                                                                      .black38,
                                                            ),
                                                            // border: OutlineInputBorder(),
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        SizedBox(
                                                          width:
                                                              double
                                                                  .infinity, // Lebar penuh
                                                          height:
                                                              50, // Tinggi sesuai kebutuhan
                                                          child: ElevatedButton(
                                                            style:
                                                                ElevatedButton.styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .blue,
                                                                ),
                                                            onPressed: () {
                                                              Get.back();
                                                              todolistController
                                                                  .updateTodo(
                                                                    todolist.id,
                                                                  );
                                                            },
                                                            child: Text(
                                                              'Simpan',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                              ),
                                                            ), // Ukuran teks lebih besar
                                                          ),
                                                        ),
                                                        SizedBox(height: 20),
                                                        SizedBox(
                                                          width:
                                                              double
                                                                  .infinity, // Lebar penuh
                                                          height:
                                                              50, // Tinggi sesuai kebutuhan
                                                          child: ElevatedButton(
                                                            style:
                                                                ElevatedButton.styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                ),
                                                            onPressed: () {
                                                              Get.back();
                                                              todolistController
                                                                  .hapusTodo(
                                                                    todolist.id,
                                                                  );
                                                            },
                                                            child: Text(
                                                              'Hapus',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                              ),
                                                            ), // Ukuran teks lebih besar
                                                          ),
                                                        ),

                                                        SizedBox(height: 100),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              isScrollControlled:
                                                  true, // Ini wajib kalau mau tinggi otomatis menyesuaikan
                                            );
                                          },
                                          icon: Icon(Icons.more_vert),
                                        )
                                        : null,
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
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
        onPressed: () {
          Get.bottomSheet(
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: SingleChildScrollView(
                // Tambahkan ini supaya responsif kalau isi lebih panjang
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Ini penting!
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
                                todolistController.resetFilter2();
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
                        onTap:
                            () => todolistController.pickDate2(context, true),
                        controller: todolistController.tambahTanggalController,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller:
                            todolistController.tambahKeteranganController,
                        style: TextStyle(color: Colors.black),
                        maxLines: 5, // Ganti ini, jangan gunakan expands.
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Uraian Pekerjaan',
                          labelStyle: TextStyle(color: Colors.black38),
                          // border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity, // Lebar penuh
                        height: 50, // Tinggi sesuai kebutuhan
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            Get.back();
                            todolistController.simpanTodo();
                          },
                          child: Text(
                            'Simpan',
                            style: TextStyle(fontSize: 18),
                          ), // Ukuran teks lebih besar
                        ),
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
            isScrollControlled:
                true, // Ini wajib kalau mau tinggi otomatis menyesuaikan
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
