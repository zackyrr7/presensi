import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/modules/home/views/home_view.dart';
import 'package:gopresent/modules/navbar/views/test.dart';
import 'package:gopresent/modules/profil/views/profil_view.dart';
import 'package:gopresent/modules/riwayat/views/riwayat_view.dart';

class MyNavbar extends StatelessWidget {
  MyNavbar({super.key});

  final RxInt selectedIndex = 0.obs;

  final List<Widget> _screens = [
    HomeView(),
    RiwayatView(),
    const SizedBox(), // kosong karena tombol tengah (Absen)
    const TestView(),
    ProfilView(),
  ];

  final List<String> _labels = ['Home', 'Riwayat', '', 'Lapker', 'Profil'];
  final List<IconData> _icons = [
    Icons.home,
    Icons.history,
    Icons.qr_code,
    Icons.schedule,
    Icons.person,
  ];

  void _onItemTapped(int index) {
    if (index == 2) return; // index 2 adalah tombol tengah, dilewati
    selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _screens[selectedIndex.value],

        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          shape: const CircularNotchedRectangle(),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(5, (index) {
                if (index == 2) {
                  return SizedBox(width: Get.width * 0.1); // space untuk FAB
                }

                final isSelected = selectedIndex.value == index;
                return InkWell(
                  onTap: () => _onItemTapped(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _icons[index],
                        size: 26,
                        color: isSelected ? Colors.white : Colors.white70,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _labels[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Aksi tombol tengah, bisa navigasi ke AbsenView
            Get.toNamed('/absen');
          },
          elevation: 5,
          shape: const CircleBorder(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.camera_alt, color: Colors.white, size: 20),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
