import 'dart:math';
import 'package:flutter/material.dart';
import 'package:attendance_app/screens/drawer.dart';
import 'package:attendance_app/components/background_painter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
            onPressed: () {
              // logoutlogic
              Navigator.pop(context);
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
                  const ProfileCard(name: "Ram Krishna", role: "Sub Inspector"),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ActionButtons(
                        label: "Mark Attendance",
                        icon: Icons.calendar_month_outlined,
                        onTap: () {
                          Navigator.pushNamed(context, '/picture');
                        },
                      ),
                      const SizedBox(width: 16.0),
                      ActionButtons(
                        label: "Provide Location",
                        icon: Icons.location_on,
                        onTap: () {
                          Navigator.pushNamed(context, '/location');
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.name,
    required this.role,
  });

  final String name;
  final String role;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: min(double.infinity, 400),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10.0,
        ),
        onPressed: () {
          // do something
        },
        // padding: const EdgeInsets.all(4.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 8.0),
              const CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/profileimg.png'),
              ),
              const SizedBox(height: 8.0),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                role,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[800],
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
        ),
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
