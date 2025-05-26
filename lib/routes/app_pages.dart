import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gopresent/bindings/AuthBinding.dart';
import 'package:gopresent/bindings/HomeBinding.dart';
import 'package:gopresent/bindings/IzinBinding.dart';
import 'package:gopresent/bindings/SakitBinding.dart';
import 'package:gopresent/modules/auth/controllers/login_controller.dart';
import 'package:gopresent/modules/auth/views/login_views.dart';
import 'package:gopresent/modules/home/views/notification_detail.dart';
import 'package:gopresent/modules/home/views/notification_view.dart';
import 'package:gopresent/modules/home/views/today_absen.dart';
import 'package:gopresent/modules/izin/view/create_izin_view.dart';
import 'package:gopresent/modules/izin/view/izin_detail_view.dart';
import 'package:gopresent/modules/izin/view/izin_view.dart';
import 'package:gopresent/modules/navbar/views/navbar_view.dart';
import 'package:gopresent/modules/riwayat/views/riwayat_view.dart';
import 'package:gopresent/modules/sakit/view/create_sakit_view.dart';
import 'package:gopresent/modules/sakit/view/detail_sakit_view.dart';
import 'package:gopresent/modules/sakit/view/sakit_view.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginViews(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.NAVBAR,
      page: () => MyNavbar(),
      bindings: [Homebinding()],
    ),
    GetPage(name: Routes.RIWAYAT, page: () => RiwayatView()),
    GetPage(name: Routes.NOTIFICATIONN, page: () => NotificationView()),
    GetPage(
      name: Routes.NOTIFICATIONDETAIL,
      page: () => NotificationDetailView(),
    ),
    GetPage(name: Routes.IZIN, page: () => IzinView(), binding: Izinbinding()),
    GetPage(name: Routes.IZINDETAIL, page: () => IzinDetailView()),
    GetPage(name: Routes.TODAYABSEN, page: () => TodayAbsenView()),
    GetPage(name: Routes.CREATEIZIN, page: () => CreateIzinView()),
    //sakit
    GetPage(
      name: Routes.SAKIT,
      page: () => SakitView(),
      binding: Sakitbinding(),
    ),
    GetPage(name: Routes.SAKITDETAIL, page: () => DetailSakitView()),
    GetPage(name: Routes.SAKITCREATE, page: () => CreateSakitView()),
  ];
}
