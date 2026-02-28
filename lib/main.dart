import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zavisoft_assignment/controllers/product_controller.dart';
import 'routes/app_routes.dart';
import 'controllers/auth_controller.dart';

void main() {
  Get.put(AuthController());
  Get.put(ProductController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daraz Style Flutter',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.orange,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          primary: Colors.orange,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      initialRoute: '/login',
      getPages: AppRoutes.routes,
    );
  }
}