class ListRiwayat {
  final String id;
  final String name;
  final String photo;
  final String jamMasuk;
  final String jamKeluar;
  final String tanggal;
  final String sakit;
  final String izin;
  final String telat;
  final String cuti;

  ListRiwayat({
    required this.id,
    required this.name,
    required this.photo,
    required this.jamMasuk,
    required this.jamKeluar,
    required this.tanggal,
    required this.sakit,
    required this.izin,
    required this.telat,
    required this.cuti,
  });

  factory ListRiwayat.fromJson(Map<String, dynamic> json) {
    return ListRiwayat(
      id: json['idpegawai'],
      name: json['namapegawai'],
      photo: json['foto'],
      jamMasuk: json['jammasuk'] ?? '',
      jamKeluar: json['jampulang'] ?? '',
      tanggal: json['tanggal'],
      sakit: json['is_sakit'].toString(),
      izin: json['is_izin'].toString(),
      telat: json['is_late'] ?? '0',
      cuti: json['is_cuti'].toString(),
    );
  }

  static List<ListRiwayat> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ListRiwayat.fromJson(item)).toList();
  }
}
