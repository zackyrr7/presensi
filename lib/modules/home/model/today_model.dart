class ListAbsens {
  final String id;
  final String name;
  final String photo;
  final String jamMasuk;
  final String jamKeluar;
  final String tanggal;
  final String sakit;
  final String izin;

  ListAbsens({
    required this.id,
    required this.name,
    required this.photo,
    required this.jamMasuk,
    required this.jamKeluar,
    required this.tanggal,
    required this.sakit,
    required this.izin,
  });

  factory ListAbsens.fromJson(Map<String, dynamic> json) {
    return ListAbsens(
      id: json['idpegawai'],
      name: json['namapegawai'],
      photo: json['foto'],
      jamMasuk: json['jammasuk'] ?? '',
      jamKeluar: json['jampulang'] ?? '',
      tanggal: json['tanggal'],
      sakit: json['is_sakit'].toString(),
      izin: json['is_izin'].toString(),
    );
  }

  static List<ListAbsens> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ListAbsens.fromJson(item)).toList();
  }
}
