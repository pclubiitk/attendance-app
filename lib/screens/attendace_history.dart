import 'package:flutter/material.dart';
import 'package:attendance_app/components/calendar.dart';

class History extends StatefulWidget {
  const History({super.key});
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  // CalendarFormat _calendarFormat = CalendarFormat.month;
  // DateTime _focusedDay = DateTime.now();
  // DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ATTENDANCE HISTORY"),
          backgroundColor: Colors.blue,
        ),
        body: const Scaffold(
          // appBar: ,
          body: Calendar(),
        ));
  }
}
