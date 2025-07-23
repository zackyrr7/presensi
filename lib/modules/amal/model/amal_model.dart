import 'package:get/get.dart';

class ListAktivitas {
  final int id;
  final String nama;
  final String? createdDate;
  final String? createdUsername;
  RxInt isDone;
  bool isModified;

  ListAktivitas({
    required this.id,
    required this.nama,
    this.createdDate,
    this.createdUsername,
    required this.isDone,
    this.isModified = false,
  });

  factory ListAktivitas.fromJson(Map<String, dynamic> json) {
    return ListAktivitas(
      id: json['id'],
      nama: json['nama'] ?? '',
      createdDate: json['created_date'],
      createdUsername: json['created_username'],
      isDone: (json['is_done'] as int).obs,
    );
  }

  static List<ListAktivitas> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ListAktivitas.fromJson(item)).toList();
  }
}
