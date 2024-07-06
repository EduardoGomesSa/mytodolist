import 'package:get/get.dart';
import 'package:mytodolist/src/pages/auth/login_page.dart';
import 'package:mytodolist/src/pages/auth/register_page.dart';
import 'package:mytodolist/src/pages/home/home_page.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
    ),
  ];
}

abstract class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
}
