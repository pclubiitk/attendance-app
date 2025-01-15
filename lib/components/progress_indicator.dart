import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui_assets/forui_assets.dart';

class ReusableProgressIndicator extends StatelessWidget {
  final double progressValue;
  final double minWidthPercentage; // Minimum width as a percentage of screen width
  final double maxWidth;

  const ReusableProgressIndicator({
    Key? key,
    required this.progressValue,
    this.minWidthPercentage = 0.8, // Default to 80%
    this.maxWidth = 400.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 24.0), // Top padding
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: screenWidth * minWidthPercentage, // Set minWidth
          maxWidth: maxWidth, // Set maxWidth
        ),
        child: LinearProgressIndicator(value: progressValue), // Progress bar
      ),
    );
  }
}
