import 'package:get/get.dart';
import 'package:gopresent/bindings/AuthBinding.dart';
import 'package:gopresent/bindings/HomeBinding.dart';
import 'package:gopresent/modules/auth/controllers/login_controller.dart';
import 'package:gopresent/modules/auth/views/login_views.dart';
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
      binding: Homebinding(),
    ),
    GetPage(name: Routes.RIWAYAT, page: () => RiwayatView()),
  ];
}
