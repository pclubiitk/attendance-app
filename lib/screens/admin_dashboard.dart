import 'dart:math';
import 'package:attendance_app/components/profile_card.dart';
import 'package:attendance_app/services/logout.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/components/drawer.dart';
import 'package:attendance_app/components/background_painter.dart';
import 'package:attendance_app/components/calendar.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _Dashboard1State();
}

class _Dashboard1State extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('DASHBOARD'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              await LogoutService().logoutAndNavigateToLogin(context);
            },
          ),
        ],
      ),
      drawer: const Drawer(child: DrawerItems()),
      body: Stack(
        children: [
          CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: BackgroundPainter(),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProfileCard(),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ActionButtons(
                        label: "View Attendance",
                        icon: Icons.calendar_month_outlined,
                        onTap: () {
                          Navigator.pushNamed(context, '/picture');
                        },
                      ),
                      const SizedBox(width: 30.0),
                      ActionButtons(
                        label: "View Location",
                        icon: Icons.location_on,
                        onTap: () {
                          Navigator.pushNamed(context, '/location');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: min(double.infinity, 400),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/usereventpage');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 10.0,
                      ),
                      child: const Calendar(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onTap;

  const ActionButtons({
    required this.label,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: ElevatedButton(
        onPressed: () {
          print("Button Pressed");
          onTap();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10.0,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.blue.withOpacity(0.2),
                ),
                child: Icon(
                  icon,
                  size: 50.0,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(label,
                  style: TextStyle(
                    letterSpacing: 2,
                    color: Colors.grey[600],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
