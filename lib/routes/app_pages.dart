import 'package:get/get.dart';
import 'package:gopresent/bindings/AuthBinding.dart';
import 'package:gopresent/bindings/HomeBinding.dart';
import 'package:gopresent/bindings/IzinBinding.dart';
import 'package:gopresent/modules/auth/controllers/login_controller.dart';
import 'package:gopresent/modules/auth/views/login_views.dart';
import 'package:gopresent/modules/home/views/notification_detail.dart';
import 'package:gopresent/modules/home/views/notification_view.dart';
import 'package:gopresent/modules/izin/view/izin_view.dart';
import 'package:gopresent/modules/navbar/views/navbar_view.dart';
import 'package:gopresent/modules/riwayat/views/riwayat_view.dart';

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
      bindings: [
        Homebinding(),
      ],
    ),
    GetPage(name: Routes.RIWAYAT, page: () => RiwayatView()),
    GetPage(name: Routes.NOTIFICATIONN, page: () => NotificationView()),
    GetPage(
      name: Routes.NOTIFICATIONDETAIL,
      page: () => NotificationDetailView(),
    ),
     GetPage(
      name: Routes.IZIN,
      page: () => IzinView(),
      binding: Izinbinding(),
    ),
  ];
}
