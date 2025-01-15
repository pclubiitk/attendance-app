// import 'package:attendance_app/config/firebase.dart';
import 'package:attendance_app/config/storage.dart';
import 'package:attendance_app/screens/PopOver.dart';
import 'package:attendance_app/screens/admin_events.dart';
import 'package:attendance_app/screens/admin_schedule.dart';
import 'package:attendance_app/screens/event_info.dart';
import 'package:attendance_app/screens/events/create_event.dart';
import 'package:attendance_app/screens/events/create_sub_event.dart';
import 'package:attendance_app/screens/new_page.dart';
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
import 'package:forui/forui.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:shadcn_ui/shadcn_ui.dart';

Future<void> main() async {
  fillData(); // Initialize shared data
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized

  // Initialize Firebase (commented out for now)
  // await FirebaseConfig.initialize();
  // FirebaseConfig.listenNotification();
  // FirebaseConfig.registerNotification();
  // FirebaseConfig.checkForInitialMessage();

  Storage.initialize(); // Initialize local storage
  runApp(const MyApp()); // Run the app
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String initialRoute = "/adminDashboard"; // Default route

  @override
  void initState() {
    super.initState();
    // Uncomment and implement token validation logic if needed
    // _checkTokenStatus();
  }

  // Future<void> _checkTokenStatus() async {
  //   bool isValid = await _tokenService.isTokenValid();
  //   if (isValid) {
  //     Map<String, dynamic>? decodedToken = await _tokenService.getDecodedToken();
  //     if (decodedToken != null) {
  //       String role = decodedToken['user']['role'] ?? '';
  //       setState(() {
  //         initialRoute = role == 'ADMIN' ? '/adminDashboard' : '/userDashboard';
  //       });
  //     }
  //   } else {
  //     Get.offNamed('/login');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ShadApp.custom(
      appBuilder: (context, theme) => GetMaterialApp(
        builder: (context, child) => FTheme(
          data: FThemes.zinc.light, // Use Forui's light theme
          child: child!,
        ),
        title: 'Attendance App',
        debugShowCheckedModeBanner: false,
        // Define routes for navigation
        routes: {
          '/login': (context) => const LoginPage(),
          '/userDashboard': (context) => const UserDashboard(),
          '/adminDashboard': (context) => const AdminDashboard(),
          '/usereventpage': (context) => const userEvents(),
          '/register': (context) => const RegistrationPage(),
          '/picture': (context) => const CapturePicPage(),
          '/profile': (context) => const ProfileScreen(),
          '/location': (context) => const LocationPage(),
          '/newpage': (context) =>  NewPage(),
          '/createsubevent': (context) =>  CreateSubEventPage(),
          '/createevent': (context) =>  CreateEventPage(),
          '/eventinfo': (context) => EventInfoPage(
                eventDetails: {
                  'title': 'Sample Event',
                  'description': 'This is a sample event description.',
                  'date': 'October 25, 2023',
                  'time': '10:00 AM - 4:00 PM',
                  'location': 'Sample Location',
                  'organizer': 'Sample Organizer',
                },
              ),
          '/adminevents': (context) =>  AdminEventsPage(),
          '/adminschedule': (context) =>  AdminSchedule(),
          '/popover': (context) => const PopoverPage(),
        },
        initialRoute: initialRoute, // Set the initial route dynamically
      ),
    );
  }
}