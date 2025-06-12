class DetailPegawai {
  final String idPegawai;
  final String namaPegawai;
  final String? tempatLahir;
  final String? tanggalLahir;
  final String alamat;
  final int idJabatan;
  final String jabatan;
  final String nik;
  final String noHp;
  final String email;
  final String? bio;
  final String foto;
  final String jk;
  final int idJamKerja;
  final String jamKerja;
  final String idWilayah;
  final int idPerusahaan;
  final int isActive;
  final String rekening;
  final int? idBank;
  final int rotateShift;
  final int idDivisi;

  DetailPegawai({
    required this.idPegawai,
    required this.namaPegawai,
    this.tempatLahir,
    this.tanggalLahir,
    required this.alamat,
    required this.idJabatan,
    required this.jabatan,
    required this.nik,
    required this.noHp,
    required this.email,
    this.bio,
    required this.foto,
    required this.jk,
    required this.idJamKerja,
    required this.jamKerja,
    required this.idWilayah,
    required this.idPerusahaan,
    required this.isActive,
    required this.rekening,
    this.idBank,
    required this.rotateShift,
    required this.idDivisi,
  });

  factory DetailPegawai.fromJson(Map<String, dynamic> json) {
    return DetailPegawai(
      idPegawai: json['idpegawai'] ?? '',
      namaPegawai: json['namapegawai'] ?? '',
      tempatLahir: json['tempatLahir'],
      tanggalLahir: json['tanggalLahir'],
      alamat: json['alamat'] ?? '',
      idJabatan: json['idjabatan'] ?? 0,
      jabatan: json['jabatan'] ?? '',
      nik: json['NIK'] ?? '',
      noHp: json['nohp'] ?? '',
      email: json['email'] ?? '',
      bio: json['bio'],
      foto: json['foto'] ?? '',
      jk: json['jk'] ?? '',
      idJamKerja: json['idjamkerja'] ?? 0,
      jamKerja: json['jamkerja'] ?? '',
      idWilayah: json['idwilayah'] ?? '',
      idPerusahaan: json['idperusahaan'] ?? 0,
      isActive: json['is_active'] ?? 0,
      rekening: json['rekening'] ?? '',
      idBank: json['idbank'],
      rotateShift: json['rotate_shift'] ?? 0,
      idDivisi: json['iddivisi'] ?? 0,
    );
  }
}
