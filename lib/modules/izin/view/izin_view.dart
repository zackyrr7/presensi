import 'package:flutter/material.dart';

class IzinView extends StatelessWidget {
  const IzinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'IZIN PEGAWAI',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
