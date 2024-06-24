import 'package:attendance_app/screens/profile_page.dart';
import 'package:attendance_app/screens/registration.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

Future<void> main() async {
  // i have made profilepage and the registrtain page
  // how to capture the image and upload it to the server is remaining
  // also all the api calls are remaining
 WidgetsFlutterBinding.ensureInitialized();
  // Obtaining a list of the available cameras on the device.
  final cameras = await availableCameras();
  runApp( MaterialApp(home: MyApp(cameras: cameras)));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  const MyApp({super.key, required this.cameras});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:RegistrationPage(cameras: cameras),
    );
  }
}

