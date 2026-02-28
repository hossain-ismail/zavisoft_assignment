import 'package:get/get.dart';
import 'package:zavisoft_assignment/controllers/auth_bindings.dart';
import 'package:zavisoft_assignment/controllers/product_bindigs.dart';
import '../screens/login_screen.dart';
import '../screens/product_listing_screen.dart';
import '../screens/profile_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      binding: AuthBindings(),
      name: '/login', page: () => LoginScreen()),
    GetPage(
      binding: ProductBindigs(),
      name: '/home', page: () => ProductListingScreen()),
    GetPage(name: '/profile', page: () => ProfileScreen()),
  ];
}
