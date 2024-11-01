import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodolist/src/bindings/app_binding.dart';
import 'package:mytodolist/src/core/routes/app_routes_pages.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My TODO List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.blue,
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      initialRoute: AppRoutes.login,
      getPages: AppPages.pages,
    );
  }
}
