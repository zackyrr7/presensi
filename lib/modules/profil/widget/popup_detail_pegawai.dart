import 'package:flutter/material.dart';
import 'package:gopresent/modules/profil/model/profile_model.dart';
import 'package:get/get.dart';

class PopupDetailPegawai extends StatelessWidget {
  const PopupDetailPegawai({super.key, required this.pegawai});

  final DetailPegawai? pegawai;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.85,
      child: Column(
        children: [
          TextFormField(
            style: TextStyle(color: Colors.black),
            readOnly: true,
            maxLines: null,
            decoration: InputDecoration(
              fillColor: Colors.white,
              labelText: 'Nama Lengkap',
              labelStyle: TextStyle(color: Colors.black38),
            ),
            initialValue: pegawai?.namaPegawai,
          ),
          SizedBox(height: 10),

          SizedBox(height: 10),
          TextFormField(
            style: TextStyle(color: Colors.black),
            readOnly: true,
            decoration: InputDecoration(
              fillColor: Colors.white,
              labelText: 'Jabatan',
              labelStyle: TextStyle(color: Colors.black38),
            ),
            initialValue: pegawai?.jabatan,
          ),
          SizedBox(height: 10),
          TextFormField(
            style: TextStyle(color: Colors.black),
            readOnly: true,
            decoration: InputDecoration(
              fillColor: Colors.white,
              labelText: 'Nomor HP',
              labelStyle: TextStyle(color: Colors.black38),
            ),
            initialValue: pegawai?.noHp,
          ),
          SizedBox(height: 10),
          TextFormField(
            style: TextStyle(color: Colors.black),
            readOnly: true,
            decoration: InputDecoration(
              fillColor: Colors.white,
              labelText: 'Jam Kerja',
              labelStyle: TextStyle(color: Colors.black38),
            ),
            initialValue: pegawai?.jamKerja,
          ),
          SizedBox(height: 10),
          TextFormField(
            style: TextStyle(color: Colors.black),
            readOnly: true,
            maxLines: null,
            decoration: InputDecoration(
              fillColor: Colors.white,
              labelText: 'Alamat',
              labelStyle: TextStyle(color: Colors.black38),
            ),
            initialValue: pegawai?.alamat,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Oke',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
