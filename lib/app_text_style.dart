import 'package:flutter/material.dart';

class AppTextStyles {
  

  // Style untuk teks putih yang mengikuti tema
  static TextStyle topForm(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      color: Theme.of(context).textTheme.titleSmall?.color, // Menggunakan warna sesuai tema
    );
  }
  static TextStyle buttonColor(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      color: Theme.of(context).textTheme.titleLarge?.color, // Menggunakan warna sesuai tema
    );
  }
}
