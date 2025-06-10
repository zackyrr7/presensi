class ModelCuti {
  final int id;
  final String tanggalAwal;
  final String tanggalAkhir;
  final String keterangan;
  final int status;
  final int jumlah;

  ModelCuti({
    required this.id,
    required this.tanggalAwal,
    required this.tanggalAkhir,
    required this.keterangan,
    required this.status,
    required this.jumlah
  });

  factory ModelCuti.fromJson(Map<String, dynamic> json) {
    return ModelCuti(
      id: json['id'],
      tanggalAwal: json['tanggalAwal'],
      tanggalAkhir: json['tanggalAkhir'],
      keterangan: json['keterangan'] ?? '',
      status: json['status'],
      jumlah: json['jumlah_hari'],
    );
  }

  static List<ModelCuti> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ModelCuti.fromJson(item)).toList();
  }
}
