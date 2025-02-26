import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mytodolist/src/bindings/app_binding.dart';
import 'package:mytodolist/src/core/routes/app_routes_pages.dart';

void main() async {
  await initializeDateFormatting('pt_BR', null);

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My ToDo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
            iconTheme: IconThemeData(color: Colors.black)),
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
