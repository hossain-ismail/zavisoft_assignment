import 'package:get/get.dart';
import '../screens/login_screen.dart';
import '../screens/product_listing_screen.dart';
import '../screens/profile_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/home', page: () => ProductListingScreen()),
    GetPage(name: '/profile', page: () => ProfileScreen()),
  ];
}
