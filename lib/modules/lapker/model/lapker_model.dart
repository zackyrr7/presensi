import 'package:get/get.dart';

class DetailModel {
  final int id;
  final String uraian;
  final String client;
  final String status;


  DetailModel({
    required this.id,
    required this.uraian,
    required this.client,
    required this.status,
  
  });

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
      id: json['id'] ?? 0,
      uraian: json['uraian'] ?? '',
      client: json['client'] ?? '',
      status: json['status'] ?? '0',
     
    );
  }

  static List<DetailModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => DetailModel.fromJson(item)).toList();
  }
}

class TanggalModel {
  final String tanggal;
  final String tanggalIndonesia;
  final List<DetailModel> detail;

  TanggalModel({
    required this.tanggal,
    required this.tanggalIndonesia,
    required this.detail,
  });

  factory TanggalModel.fromJson(Map<String, dynamic> json) {
    return TanggalModel(
      tanggal: json['tanggal'] ?? '',
      tanggalIndonesia: json['tanggalIndonesia'] ?? '',
      detail: DetailModel.fromJsonList(json['detail'] ?? []),
    );
  }

  static List<TanggalModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => TanggalModel.fromJson(item)).toList();
  }
}

class TanggalResponse {
  final bool status;
  final String message;
  final List<TanggalModel> data;

  TanggalResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TanggalResponse.fromJson(Map<String, dynamic> json) {
    return TanggalResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: TanggalModel.fromJsonList(json['data'] ?? []),
    );
  }
}
