import 'package:attendance_app/config/firebase.dart';
import 'package:attendance_app/config/storage.dart';
import 'package:attendance_app/screens/user_dashboard.dart';
import 'package:attendance_app/screens/admin_dashboard.dart';
import 'package:attendance_app/screens/user_events.dart';
import 'package:attendance_app/screens/capture_pic.dart';
import 'package:attendance_app/screens/login_page.dart';
import 'package:attendance_app/screens/registration.dart';
import 'package:attendance_app/screens/profile.dart';
import 'package:attendance_app/screens/location_page.dart';
import 'package:attendance_app/services/store.dart';
import 'package:attendance_app/src/shared/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  fillData();
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseConfig.initialize();
  FirebaseConfig.listenNotification();
  FirebaseConfig.registerNotification();
  FirebaseConfig.checkForInitialMessage();
  Storage.initialize();
  runApp(const MyApp()); // Use MyApp directly
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TokenService _tokenService = TokenService();
  String initialRoute = "/login"; // Default route to '/login'

  @override
  void initState() {
    super.initState();
    _checkTokenStatus();
  }

  Future<void> _checkTokenStatus() async {
    bool isValid = await _tokenService.isTokenValid();
    if (isValid) {
      // Token is valid, check the role
      Map<String, dynamic>? decodedToken =
          await _tokenService.getDecodedToken();
      if (decodedToken != null) {
        String role = decodedToken['user']['role'] ?? '';
        setState(() {
          initialRoute = role == 'ADMIN' ? '/adminDashboard' : '/userDashboard';
          // Navigate to the role-specific page
          Get.offNamed(initialRoute); // Navigate here
        });
      }
    } else {
      // Token is not valid or doesn't exist, navigate to login
      Get.offNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Use GetMaterialApp here
      title: 'Attendance App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      routes: {
        '/login': (context) => const LoginPage(),
        '/userDashboard': (context) => const UserDashboard(),
        '/adminDashboard': (context) => const AdminDashboard(),
        '/usereventpage': (context) => const userEvents(),
        '/register': (context) => const RegistrationPage(),
        '/picture': (context) => const CapturePicPage(),
        '/profile': (context) => const ProfileScreen(),
        '/location': (context) => const LocationPage(),
      },
      initialRoute: initialRoute, // Default, but overridden by dynamic routing
    );
  }
}
