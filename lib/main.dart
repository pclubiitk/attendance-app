import 'package:attendance_app/screens/login_page.dart';
import 'package:attendance_app/screens/home_page.dart';
import 'package:attendance_app/screens/registration.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get.dart';

Future<void> main() async {
  // i have made profilepage and the registrtain page
  // how to capture the image and upload it to the server is remaining
  // also all the api calls are remaining
 WidgetsFlutterBinding.ensureInitialized();
  runApp( const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    const String initialRoute = "/register";
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
        '/home': (context) => const HomePage(),
        '/register': (context) => RegistrationPage(),
      },
    );
  }
}
