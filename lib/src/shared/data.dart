// import 'package:flutter/material.dart';

import 'utils.dart';

class AttendanceManager {
  final Map<DateTime, bool> _attendance = {};

  // Function to set attendance for a specific date
  void setAttendance(DateTime date, bool isPresent) {
    _attendance[normalizeDate(date)] = isPresent;
  }

  // Function to set/update attendance for multiple dates
  void updateAttendance(Map<DateTime, bool> attendanceUpdates) {
    attendanceUpdates.forEach((date, isPresent) {
      _attendance[normalizeDate(date)] = isPresent;
    });
  }

  // Function to get attendance for a specific date
  bool? getAttendance(DateTime date) {
    return _attendance[normalizeDate(date)] == true;
  }

  // Function to check if a date is absent
  bool isAbsent(DateTime date) {
    return _attendance[normalizeDate(date)] == false;
  }

  // Function to retrieve the entire attendance map
  Map<DateTime, bool> getAllAttendance() {
    return _attendance;
  }
}

// super important infrastructure
AttendanceManager attendanceManager = AttendanceManager();

void fillData() { //dummy data
  // Example of setting attendance for a specific date
  attendanceManager.setAttendance(DateTime(2024, 8, 15), false);
  attendanceManager.setAttendance(DateTime(2024, 8, 16), true);

  // Example of updating attendance for multiple dates
  attendanceManager.updateAttendance({
    DateTime(2024, 8, 22): true,
    DateTime(2024, 8, 23): false,
  });
}
