class LemburDetail {
  final int id;
  final int status;
  final String uraianPekerjaan;

  LemburDetail({
    required this.id,
    required this.status,
    required this.uraianPekerjaan,
  });

  factory LemburDetail.fromJson(Map<String, dynamic> json) {
    return LemburDetail(
      id: json['id'],
      status: json['status'],
      uraianPekerjaan: json['uraian_pekerjaan'] ?? '',
    );
  }

  static List<LemburDetail> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => LemburDetail.fromJson(e)).toList();
  }
}

class LemburItem {
  final String tanggal;
  final String mulai;
  final String selesai;
  final int jumlah;
  final List<LemburDetail> data;

  LemburItem({
    required this.tanggal,
    required this.mulai,
    required this.selesai,
    required this.jumlah,
    required this.data,
  });

  factory LemburItem.fromJson(Map<String, dynamic> json) {
    return LemburItem(
      tanggal: json['tanggal'],
      mulai: json['mulai'],
      selesai: json['selesai'],
      jumlah: json['jumlah'],
      data: LemburDetail.fromJsonList(json['data']),
    );
  }

  static List<LemburItem> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => LemburItem.fromJson(e)).toList();
  }
}
