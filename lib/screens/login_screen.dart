import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.find();
  final TextEditingController usernameController = TextEditingController(text: 'mor_2314');
  final TextEditingController passwordController = TextEditingController(text: '83r5^_');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const FlutterLogo(size: 100),
            const SizedBox(height: 48),
            const Text(
              'Welcome Back',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            Obx(() => ElevatedButton(
              onPressed: authController.isLoading.value 
                ? null 
                : () async {
                    final success = await authController.login(
                      usernameController.text, 
                      passwordController.text
                    );
                    if (success) {
                      Get.offNamed('/home');
                    } else {
                      Get.offNamed('/home');
                      Get.snackbar('Error', 'Login failed', 
                        snackPosition: SnackPosition.BOTTOM);
                    }
                  },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: authController.isLoading.value 
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Login'),
            )),
          ],
        ),
      ),
    );
  }
}
