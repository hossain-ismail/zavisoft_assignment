import 'package:get/get.dart';
import 'package:zavisoft_assignment/controllers/product_controller.dart';

class ProductBindigs extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductController());
  }
}