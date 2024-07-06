import 'package:flutter/material.dart';
import 'package:attendance_app/components/background_painter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("ATTENDANCE HISTORY"),
      ),
      body: Scaffold(
          // appBar: ,
          body: Stack(
        children: [
          CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: BackgroundPainter(),
          ),
          Column(
            children: [
              // calendar code here.
            ],
          ),
        ],
      )),
    );
  }
}
