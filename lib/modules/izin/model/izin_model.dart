class ListIzin {
  final String id;
  final String tanggalAwal;
  final String tanggalAkhir;
  final String keterangan;
  final int status;
  final int jumlah;

  ListIzin({
    required this.id,
    required this.tanggalAwal,
    required this.tanggalAkhir,
    required this.keterangan,
    required this.status,
    required this.jumlah
  });

  factory ListIzin.fromJson(Map<String, dynamic> json) {
    return ListIzin(
      id: json['id'],
      tanggalAwal: json['tanggalAwal'],
      tanggalAkhir: json['tanggalAkhir'],
      keterangan: json['keterangan'] ?? '',
      status: json['status'],
      jumlah: json['jumlah_hari'],
    );
  }

  static List<ListIzin> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ListIzin.fromJson(item)).toList();
  }
}
