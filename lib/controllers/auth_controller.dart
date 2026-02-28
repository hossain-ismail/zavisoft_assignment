import 'package:get/get.dart';
import '../services/api_service.dart';
import '../models/user.dart';

class AuthController extends GetxController {
  final ApiService _apiService = ApiService();
  
  var isLoading = false.obs;
  var token = RxnString();
  var user = Rxn<User>();

  Future<bool> login(String username, String password) async {
    isLoading.value = true;
    final res = await _apiService.login(username, password);
    if (res != null) {
      token.value = res;
      // Fakestore doesn't return user id with token, 
      // typically we'd decode JWT or have another endpoint.
      // For this assignment, we'll fetch user 1 if successful.
      user.value = await _apiService.getUserProfile(1);
      isLoading.value = false;
      return true;
    }
    isLoading.value = false;
    return false;
  }

  void logout() {
    token.value = null;
    user.value = null;
    Get.offAllNamed('/login');
  }

  bool get isLoggedIn => token.value != null;
}
