class ModelSakit {
  final int id;
  final String tanggal;

  final String keterangan;

  ModelSakit({
    required this.id,
    required this.tanggal,
    required this.keterangan,
  });

  factory ModelSakit.fromJson(Map<String, dynamic> json) {
    return ModelSakit(
      id: json['id'],
      tanggal: json['tanggal'],
      keterangan: json['keterangan'] ?? '',
    );
  }

  static List<ModelSakit> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ModelSakit.fromJson(item)).toList();
  }
}
