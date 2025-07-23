import 'package:get/get.dart';

class TodoListModel {
  final int id;
  final String? idPegawai;
  final String? tanggal;
  final String nama;
  final int isStatis;
  final int createdByAdmin;
  final String createdDate;
  final String? createdUsername;
  final RxInt isDone;

  TodoListModel({
    required this.id,
    this.idPegawai,
    this.tanggal,
    required this.nama,
    required this.isStatis,
    required this.createdByAdmin,
    required this.createdDate,
    this.createdUsername,
    required this.isDone,
  });

  factory TodoListModel.fromJson(Map<String, dynamic> json) {
    return TodoListModel(
      id: json['id'] ?? 0,
      idPegawai: json['idpegawai']?.toString(),
      tanggal: json['tanggal'],
      nama: json['nama'] ?? '',
      isStatis: int.tryParse(json['is_statis']?.toString() ?? '0') ?? 0,
      createdByAdmin: json['created_by_admin'] ?? 0,
      createdDate: json['created_date'] ?? '',
      createdUsername: json['created_username'],
      isDone:(json['is_done']as int).obs,
    );
  }

  static List<TodoListModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => TodoListModel.fromJson(item)).toList();
  }
}
