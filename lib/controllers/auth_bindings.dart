import 'package:get/get.dart';
import 'package:zavisoft_assignment/controllers/auth_controller.dart';

class AuthBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}