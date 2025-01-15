import 'package:flutter/material.dart';
import 'package:attendance_app/components/bottom_navbar.dart';
import 'package:attendance_app/screens/admin_events.dart';
import 'package:attendance_app/screens/admin_schedule.dart';
import 'package:attendance_app/screens/new_page.dart';
import 'package:attendance_app/screens/profile.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;

  // List of pages for each tab
  final List<Widget> _pages = [
     NewPage(), // Replace with your actual Home page
     AdminEventsPage(),
     AdminSchedule(),
    const ProfileScreen(),
  ];

  void _onTabChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Handle back button press
  Future<bool> _onWillPop() async {
    if (_currentIndex != 0) {
      // If not on the home tab, switch to the home tab
      setState(() {
        _currentIndex = 0;
      });
      return false; // Prevent the app from exiting
    } else {
      // If on the home tab, allow the app to exit
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // Handle back button press
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTabChange: _onTabChange,
        ),
      ),
    );
  }
}
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: const Text('DASHBOARD'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             tooltip: 'Logout',
//             onPressed: () async {
//               await LogoutService().logoutAndNavigateToLogin(context);
//             },
//           ),
//         ],
//       ),
//       drawer: const Drawer(child: DrawerItems()),
//       body: Stack(
//         children: [
//           CustomPaint(
//             size: const Size(double.infinity, double.infinity),
//             painter: BackgroundPainter(),
//           ),
//           Container(
//             padding: const EdgeInsets.all(16.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   ProfileCard(),
//                   const SizedBox(height: 20.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ActionButtons(
//                         label: "View Attendance",
//                         icon: Icons.calendar_month_outlined,
//                         onTap: () {
//                           Navigator.pushNamed(context, '/picture');
//                         },
//                       ),
//                       const SizedBox(width: 30.0),
//                       ActionButtons(
//                         label: "View Location",
//                         icon: Icons.location_on,
//                         onTap: () {
//                           Navigator.pushNamed(context, '/location');
//                         },
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20.0),
//                   SizedBox(
//                     width: min(double.infinity, 400),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/usereventpage');
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         elevation: 10.0,
//                       ),
//                       child: const Calendar(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ActionButtons extends StatelessWidget {
//   final String label;
//   final IconData icon;
//   final Function onTap;

//   const ActionButtons({
//     required this.label,
//     required this.icon,
//     required this.onTap,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Flexible(
//       flex: 1,
//       child: ElevatedButton(
//         onPressed: () {
//           print("Button Pressed");
//           onTap();
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           elevation: 10.0,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
//           child: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50.0),
//                   color: Colors.blue.withOpacity(0.2),
//                 ),
//                 child: Icon(
//                   icon,
//                   size: 50.0,
//                   color: Colors.blue,
//                 ),
//               ),
//               const SizedBox(height: 8.0),
//               Text(label,
//                   style: TextStyle(
//                     letterSpacing: 2,
//                     color: Colors.grey[600],
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
