import 'package:attendance_app/screens/userdashboard.dart';
import 'package:attendance_app/screens/adminDashboard.dart';
import 'package:attendance_app/screens/capturepic.dart';
import 'package:attendance_app/screens/login_page.dart';
import 'package:attendance_app/screens/attendace_history.dart';
import 'package:attendance_app/screens/registration.dart';
import 'package:attendance_app/screens/profile.dart';
import 'package:attendance_app/screens/locationpage.dart';
import 'package:attendance_app/src/shared/data.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get.dart';

Future<void> main() async {
  fillData();
  // how to capture the image and upload it to the server is remaining
  // also all the api calls are remaining
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  // final List<CameraDescription> cameras;

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    const String initialRoute = "/login";
    return GetMaterialApp(
      title: 'Attendance App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      routes: {
        '/login': (context) => const LoginPage(),
        '/history': (context) => const History(),
        '/userDashboard': (context) => const userDashboard(),
        '/adminDashboard': (context) => const adminDashboard(),
        '/register': (context) => const RegistrationPage(),
        '/picture': (context) => const CapturePicPage(),
        '/profile': (context) => const ProfileScreen(),
        '/location': (context) => const LocationPage(),
        
        
      },
    );
  }
}
