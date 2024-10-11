import 'package:flutter/material.dart';
import 'package:get/get.dart'; // or use Navigator.pushNamed if you're not using GetX
import 'package:attendance_app/services/store.dart'; // TokenService path

class LogoutService {
  final TokenService _tokenService = TokenService();

  Future<void> logoutAndNavigateToLogin(BuildContext context) async {
    // Delete the token
    await _tokenService.deleteToken();

    // Navigate to the login page
    // Navigator.pushNamed(context, '/login');

    // This clears the navigation stack
    Get.offAllNamed('/login');
  }
}
