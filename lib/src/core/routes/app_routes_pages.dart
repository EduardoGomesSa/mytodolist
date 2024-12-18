import 'package:get/get.dart';
import 'package:mytodolist/src/bindings/item_binding.dart';
import 'package:mytodolist/src/bindings/profile_binding.dart';
import 'package:mytodolist/src/bindings/task_binding.dart';
import 'package:mytodolist/src/pages/auth/login_page.dart';
import 'package:mytodolist/src/pages/auth/register_page.dart';
import 'package:mytodolist/src/pages/home/home_page.dart';
import 'package:mytodolist/src/pages/profile/profile_page.dart';
import 'package:mytodolist/src/pages/splash_page.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      bindings: [
        TaskBinding(),
        ProfileBinding(),
        ItemBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterPage(),
    ),
    GetPage(
      name: AppRoutes.profile, 
      page: () => const ProfilePage(),
    ),
    GetPage(
      name: AppRoutes.splash, 
      page: () => const SplashPage(),
    ),
  ];
}

abstract class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String splash = '/splash';
  static const String profile = '/profile';
}
